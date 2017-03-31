function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
% run(fullfile(fileparts(mfilename('fullpath')), ...
%   '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

% opts.train.gpus = [1];



%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below
if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
p = mfilename('fullpath');
p_file = mfilename();
path_to_loc = p(1:end-length(p_file));

path_to_loc = strcat(path_to_loc, 'data\Caltech4\ImageData\');


% Build Trainingset
categories_1 = {'airplanes_train', 'cars_train', 'faces_train', 'motorbikes_train'};
imd_train = imageDatastore(fullfile(path_to_loc, categories_1), 'LabelSource', 'foldernames');

% Build TestSet:
categories_2 = {'airplanes_test', 'cars_test', 'faces_test', 'motorbikes_test'};
imd_test = imageDatastore(fullfile(path_to_loc, categories_2), 'LabelSource', 'foldernames');

% Loop Trough the datasets
data = single(zeros(32,32,3,length(imd_test.Labels)+length(imd_train.Labels)));
labels = single(zeros(1,length(imd_test.Labels)+length(imd_train.Labels)));
sets = single(zeros(1,length(imd_test.Labels)+length(imd_train.Labels)));
for i = 1:length(imd_train.Labels)
    label = imd_train.Labels(i); % Gives the label of the image that is read
    img = im2single(imresize(readimage(imd_train,i),[32 32]));
    [x,y,z] = size(img);
    data(1:x,1:y,1:z,i) = img;
    if label == 'airplanes_train'
        labels(i) = single(1);
    elseif label == 'cars_train'
        labels(i) = single(2);
    elseif label == 'faces_train'
        labels(i) = single(3);
    elseif label == 'motorbikes_train'
        labels(i) = single(4);
    end
    
    sets(i) = single(1);
end

xtra_length = length(imd_train.Labels);

for i = 1:length(imd_test.Labels)
    label = imd_test.Labels(i); % Gives the label of the image that is read
    img = im2single(imresize(readimage(imd_test,i),[32 32]));
    [x,y,z] = size(img);
    data(1:x,1:y,1:z,i+xtra_length) = img;
    
    if label == 'airplanes_test'
        labels(i+xtra_length) = single(1);
    elseif label == 'cars_test'
        labels(i+xtra_length) = single(2);
    elseif label == 'faces_test'
        labels(i+xtra_length) = single(3);
    elseif label == 'motorbikes_test'
        labels(i+xtra_length) = single(4);
    end
    sets(i+xtra_length) = single(2);    
end

size(data)

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = single(sets);
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end

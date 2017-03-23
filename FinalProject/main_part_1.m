function main_part_1()
%% Main function for first part.

% Step 0: read in all the images.
p = mfilename('fullpath');
p_file = mfilename();
path_to_loc = p(1:end-length(p_file));

path_to_loc = strcat(path_to_loc, 'Caltech4\ImageData\');

categories_1 = {'airplanes_train', 'cars_train', 'faces_train', 'motorbikes_train'};
imd_train = imageDatastore(fullfile(path_to_loc, categories_1), 'LabelSource', 'foldernames');
imd_kmeans_vocab = splitEachLabel(imd_train,50);
% Step 1: Feature extraction.
SIFT_matrix = single(ones(128,1));

disp('Start the Feature extraction of the top set of images')

for i = 1:length(imd_kmeans_vocab.Labels)
    imd_kmeans_vocab.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_kmeans_vocab,i);
    % Extract the SIFT features to create a K_means matrix needed to find
    % the centres fot the vocal words.
    img = im2single(img);
    [f, d] = feature_extraction(img, 'SIFT');
    SIFT_matrix = [SIFT_matrix, single(d)];   
end

disp('K-means locating the centroids')
% Step 2: Visual vocabulary
[C] = vl_kmeans(SIFT_matrix,400,'MaxNumIterations',100);

% Transpose to get correct columns
C = C';

disp('Quantize the features of all the different images')
% Step 3: Quantize features using vocabulary
data = single(zeros(1,400));
label_air = [0];
label_car = [0];
label_face = [0];
label_bike = [0];

for i = 1:length(imd_train.Labels)
    label = imd_train.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_train,i);
    img = im2single(img);
    [f, d] = feature_extraction(img, 'SIFT');
    k = dsearchn(C,single(d)');
    % Step 4: Representing images by frequencies
    hist_im = hist(k,400);
    hist_im = hist_im ./ max(hist_im);
    data = [data;hist_im];    
    if label == 'airplanes_train'
        label_air = [label_air;1];
        label_car = [label_car;0];
        label_face = [label_face;0];
        label_bike = [label_bike;0];
    elseif label == 'cars_train'
        label_air = [label_air;0];
        label_car = [label_car;1];
        label_face = [label_face;0];
        label_bike = [label_bike;0];
    elseif label == 'faces_train'
        label_air = [label_air;0];
        label_car = [label_car;0];
        label_face = [label_face;1];
        label_bike = [label_bike;0];
    elseif label == 'motorbikes_train'
        label_air = [label_air;0];
        label_car = [label_car;0];
        label_face = [label_face;0];
        label_bike = [label_bike;1];
    end
end

disp('Classification')
% Step 5: Classification.

SVMModel_air = fitcsvm(data,label_air);
SVMModel_car = fitcsvm(data,label_car);
SVMModel_face = fitcsvm(data,label_face);
SVMModel_bike = fitcsvm(data,label_bike);

disp('Testing')

% Build TestSet:
categories_2 = {'airplanes_test', 'cars_test', 'faces_test', 'motorbikes_test'};
imd_test = imageDatastore(fullfile(path_to_loc, categories_2), 'LabelSource', 'foldernames');

tot_score = [0,0,0,0];
correct = 0;
for i = 1:length(imd_test.Labels)
    label = imd_test.Labels(i); % Gives the label of the image that is read
    if label == 'airplanes_test'
        label_score = 1;
    elseif label == 'cars_test'
        label_score = 2;
    elseif label == 'faces_test'
        label_score = 3;
    elseif label == 'motorbikes_test'
        label_score = 4;
    end
    img = readimage(imd_test,i);
    img = im2single(img);
    [f, d] = feature_extraction(img, 'SIFT');
    k = dsearchn(C,double(d)');
    scores_vocab = hist(k,400);
    scores_vocab = scores_vocab ./ max(scores_vocab);
    score = [predict(SVMModel_air,scores_vocab),predict(SVMModel_car,scores_vocab),predict(SVMModel_face,scores_vocab),predict(SVMModel_bike,scores_vocab)];
    if score(label_score) == 1
        correct = correct + 1;
    end
    tot_score = [tot_score;score];
end
disp('Average precision: ')
disp(correct/length(imd_test.Labels))
end 






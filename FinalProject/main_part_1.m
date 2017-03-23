function main_part_1()
%% Main function for first part.

% Step 0: read in all the images.
p = mfilename('fullpath');
p_file = mfilename();
path_to_loc = p(1:end-length(p_file));

path_to_loc = strcat(path_to_loc, 'Caltech4\ImageData\');

categories_1 = {'airplanes_train', 'cars_train', 'faces_train', 'motorbikes_train'};
categories_2 = {'airplanes_test', 'cars_test', 'faces_test', 'motorbikes_test'};

imd_train = imageDatastore(fullfile(path_to_loc, categories_1), 'LabelSource', 'foldernames');
imd_test = imageDatastore(fullfile(path_to_loc, categories_2), 'LabelSource', 'foldernames');

% Step 1: Feature extraction.
SIFT_matrix = double(ones(128,1));

for i = 1:10
    imd_train.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_train,i);
    % Extract the SIFT features to create a K_means matrix needed to find
    % the centres fot the vocal words.
    [f, d] = feature_extraction(img, 'SIFT');
    SIFT_matrix = [SIFT_matrix, double(d)];   
end

% Step 2: Visual vocabulary
[C] = vl_kmeans(SIFT_matrix,400,'MaxNumIterations',100);
% Transpose to get correct columns
C = C';

% Step 3: Quantize features using vocabulary
for i = 20:30
    imd_train.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_train,i);
    [f, d] = feature_extraction(img, 'SIFT');
    k = dsearchn(C,double(d)');
    % Step 4: Representing images by frequencies
    h = histogram(k,400);
end

% Step 5: Classification.



end 
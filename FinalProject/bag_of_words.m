function [air, car, face, bike] = bag_of_words(vocab_size, sift_type)
%% Main function for first part.

max_h = 0;
max_w = 0;


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

% Setting the bin_size
x = linspace(1,vocab_size,vocab_size);

disp('Start the Feature extraction of the top set of images')

for i = 1:length(imd_kmeans_vocab.Labels)
    imd_kmeans_vocab.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_kmeans_vocab,i);
    % Extract the SIFT features to create a K_means matrix needed to find
    % the centres fot the vocal words.
    img = im2single(img);
    [f, d] = feature_extraction(img, sift_type);
    SIFT_matrix = [SIFT_matrix, single(d)];   
end

disp('K-means locating the centroids')
% Step 2: Visual vocabulary
[C] = vl_kmeans(SIFT_matrix,vocab_size,'MaxNumIterations',100);

% Transpose to get correct columns
C = C';

disp('Quantize the features of all the different images')
% Step 3: Quantize features using vocabulary
data = double(zeros(length(imd_train.Labels),vocab_size));
label_air = zeros(length(imd_train.Labels),1);
label_car = zeros(length(imd_train.Labels),1);
label_face = zeros(length(imd_train.Labels),1);
label_bike = zeros(length(imd_train.Labels),1);

for i = 1:length(imd_train.Labels)
    label = imd_train.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_train,i);
    img = im2single(img);
    [f, d] = feature_extraction(img, 'SIFT');
    k = dsearchn(C,single(d)');
    % Step 4: Representing images by frequencies
    hist_im = hist(k,x);
    hist_im = double(hist_im ./ max(hist_im));
    data(i,:) = hist_im;    
    if label == 'airplanes_train'
        label_air(i) = 1;
    elseif label == 'cars_train'
        label_car(i) = 1;
    elseif label == 'faces_train'
        label_face(i) = 1;
    elseif label == 'motorbikes_train'
        label_bike(i) = 1;
    end
end


disp('Classification')
% Step 5: Classification.

SVMModel_air = train(double(label_air), sparse(data));
SVMModel_car = train(double(label_car), sparse(data));
SVMModel_face = train(double(label_face), sparse(data));
SVMModel_bike = train(double(label_bike), sparse(data));

disp('Testing')

% Build TestSet:
categories_2 = {'airplanes_test', 'cars_test', 'faces_test', 'motorbikes_test'};
imd_test = imageDatastore(fullfile(path_to_loc, categories_2), 'LabelSource', 'foldernames');

data_test = double(zeros(length(imd_test.Labels),vocab_size));
test_air = zeros(length(imd_test.Labels),1);
test_car = zeros(length(imd_test.Labels),1);
test_face = zeros(length(imd_test.Labels),1);
test_bike = zeros(length(imd_test.Labels),1);
file_loc = strings(length(imd_test.Labels),1);

for i = 1:length(imd_test.Labels)
    label = imd_test.Labels(i); % Gives the label of the image that is read
    [img,fileinfo] = readimage(imd_test,i);
    file_loc(i) = fileinfo.Filename;
    img = im2single(img);
    [f, d] = feature_extraction(img, 'SIFT');
    k = dsearchn(C,single(d)');
    % Step 4: Representing images by frequencies
    hist_im = hist(k,x);
    hist_im = double(hist_im ./ max(hist_im));
    data_test(i,:) = hist_im;    
    if label == 'airplanes_test'
        test_air(i) = 1;
    elseif label == 'cars_test'
        test_car(i) = 1;
    elseif label == 'faces_test'
        test_face(i) = 1;
    elseif label == 'motorbikes_test'
        test_bike(i) = 1;
    end
end

% [predicted_label, accuracy_air, decision_values]
[predicted_label, accuracy, decision_values] = predict(double(test_air), sparse(data_test), SVMModel_air);
air = [decision_values, file_loc];
[elem_sort,index_sort] = sort(double(air(:,1)),'descend');
air = air(index_sort,:);
[predicted_label, accuracy, decision_values] = predict(double(test_car), sparse(data_test), SVMModel_car);
car = [decision_values, file_loc];
[elem_sort,index_sort] = sort(double(car(:,1)),'descend');
car = car(index_sort,:);
[predicted_label, accuracy, decision_values] = predict(double(test_face), sparse(data_test), SVMModel_face);
face = [decision_values, file_loc];
[elem_sort,index_sort] = sort(double(face(:,1)),'descend');
face = face(index_sort,:);
[predicted_label, accuracy, decision_values] = predict(double(test_bike), sparse(data_test), SVMModel_bike);
bike = [decision_values, file_loc];
[elem_sort,index_sort] = sort(double(bike(:,1)),'descend');
bike = bike(index_sort,:);

% Use the decision variable to calculate the mean average precision.
end 






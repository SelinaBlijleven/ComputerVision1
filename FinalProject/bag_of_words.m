function [air, car, face, bike, accuracy_all] = bag_of_words(vocab_size, feature_method, learning_method)
%% Main function for first part.
% Execute the bag of words approach.

% Input
% vocab_size: Vocabulary size for the image 'words'
% feature_method: Method for feature extraction (SIFT and its variants/HoG)
% learning_method: Classifier method

% Step 0: read in all the images.
p = mfilename('fullpath');
p_file = mfilename();
path_to_loc = p(1:end-length(p_file));

path_to_loc = strcat(path_to_loc, 'data\Caltech4\ImageData\');

categories_1 = {'airplanes_train', 'cars_train', 'faces_train', 'motorbikes_train'};
imd_train = imageDatastore(fullfile(path_to_loc, categories_1), 'LabelSource', 'foldernames');
imd_kmeans_vocab = splitEachLabel(imd_train,50);

% retrieving the size of the SIFT_matrix


% Step 1: Feature extraction.
if strcmp(feature_method,'denseSIFT')
    SIFT_matrix = single(zeros(128,length(imd_kmeans_vocab.Labels)*20000));
else
    img = readimage(imd_kmeans_vocab,1);
    img = im2single(img);
    d = feature_extraction(img, feature_method);
    [feature_size, ~] = size(single(d));
    SIFT_matrix = single(zeros(feature_size,length(imd_kmeans_vocab.Labels)*1800));
end
% Setting the bin_size
x = linspace(1,vocab_size,vocab_size);

disp('Start the Feature extraction of the top set of images')
loc_elem = 1;

for i = 1:length(imd_kmeans_vocab.Labels)
    imd_kmeans_vocab.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_kmeans_vocab,i);
    % Extract the SIFT features to create a K_means matrix needed to find
    % the centres fot the vocal words.
    img = im2single(img);
    
    % Check if RGB or grayscale
    if numel(size(img))>=3 || not(strncmp(fliplr(feature_method),fliplr('SIFT'),4))
        % If image is RGB perform given SIFT type.
        d = feature_extraction(img, feature_method);
    else
        % If image is grayscale default to standard SIFT.
        disp('Grayscale image found. ColorSIFT is not supported.')
        disp('Now using standard SIFT.')
        d = feature_extraction(img, 'SIFT');
    end
    [~, length_dense_size] = size(single(d));
    loc_elem_new = loc_elem + length_dense_size;
    SIFT_matrix(:,loc_elem:loc_elem_new-1) = single(d);
    loc_elem = loc_elem_new;
end
SIFT_matrix(:, loc_elem_new:end) = [];

disp('K-means locating the centroids')
% Step 2: Construct visual vocabulary
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
    if numel(size(img))>=3 || not(strncmp(fliplr(feature_method),fliplr('SIFT'),4))
        d = feature_extraction(img, feature_method);
    else
        d = feature_extraction(img, 'SIFT');
    end
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

disp('Now performing classification')
% Step 5: Classification.

if strcmp(learning_method, 'k-nearest')
    KNN_air = fitcknn(sparse(data), double(label_air));
    KNN_car = fitcknn(sparse(data), double(label_car));
    KNN_face = fitcknn(sparse(data), double(label_face));
    KNN_bike = fitcknn(sparse(data), double(label_bike));
    
else
    SVMModel_air = train(double(label_air), sparse(data));
    SVMModel_car = train(double(label_car), sparse(data));
    SVMModel_face = train(double(label_face), sparse(data));
    SVMModel_bike = train(double(label_bike), sparse(data));
end

disp('Testing classifications')
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
    file_loc(i) = strrep(fileinfo.Filename,path_to_loc,'');
    img = im2single(img);
    if numel(size(img))>=3 || not(strncmp(fliplr(feature_method),fliplr('SIFT'),4))
        d = feature_extraction(img, feature_method);
    else
        d = feature_extraction(img, 'SIFT');
    end
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
if strcmp(learning_method, 'k-nearest')
    [predicted_label, decision_values, ~] = predict(KNN_air, data_test);
    air = [decision_values, file_loc, predicted_label, test_air];
    [~,index_sort] = sort(double(air(:,1)),'descend');
    air = air(index_sort,:);
    
    [predicted_label, decision_values, ~] = predict(KNN_car, data_test);
    car = [decision_values, file_loc, predicted_label, test_car];
    [~,index_sort] = sort(double(car(:,1)),'ascend');
    car = car(index_sort,:);
    
    [predicted_label, decision_values, ~] = predict(KNN_face, data_test);
    face = [decision_values, file_loc, predicted_label, test_face];
    [~,index_sort] = sort(double(face(:,1)),'ascend');
    face = face(index_sort,:);
    
    [predicted_label, decision_values, ~] = predict(KNN_bike, data_test);
    bike = [decision_values, file_loc, predicted_label, test_bike];
    [~,index_sort] = sort(double(bike(:,1)),'ascend');
    bike = bike(index_sort,:);
    
else
    [predicted_label, acc_air, decision_values] = predict(double(test_air), sparse(data_test), SVMModel_air);
    air = [decision_values, file_loc, predicted_label, test_air];
    [~,index_sort] = sort(double(air(:,1)),'descend');
    air = air(index_sort,:);
    
    [predicted_label, acc_car, decision_values] = predict(double(test_car), sparse(data_test), SVMModel_car);
    car = [decision_values, file_loc, predicted_label, test_car];
    [~,index_sort] = sort(double(car(:,1)),'ascend');
    car = car(index_sort,:);
    
    [predicted_label, acc_face, decision_values] = predict(double(test_face), sparse(data_test), SVMModel_face);
    face = [decision_values, file_loc, predicted_label, test_face];
    [~,index_sort] = sort(double(face(:,1)),'ascend');
    face = face(index_sort,:);
    
    [predicted_label, acc_bike, decision_values] = predict(double(test_bike), sparse(data_test), SVMModel_bike);
    bike = [decision_values, file_loc, predicted_label, test_bike];
    [~,index_sort] = sort(double(bike(:,1)),'ascend');
    bike = bike(index_sort,:);
end

% Use the decision variable to calculate the mean average precision.
frac_vocab = length(imd_kmeans_vocab.Labels)/length(imd_train.Labels);
pos_val = sum(test_bike == 1);
neg_val = sum(test_bike == 0);
if strcmp(feature_method,'denseSIFT')
    html_print(air, car, face, bike, 3, 3, feature_method, vocab_size, frac_vocab, pos_val, neg_val, 'Linear')
else
    html_print(air, car, face, bike, 'NaN', 'NaN', feature_method, vocab_size, frac_vocab, pos_val, neg_val, 'Linear')
end

accuracy_all = [acc_air,acc_car,acc_face,acc_bike];
end 
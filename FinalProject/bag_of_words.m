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

% Step 1: Feature extraction.

feature_matrix = feature_extractor(imd_kmeans_vocab, feature_method);

disp('K-means locating the centroids')
% Step 2: Construct visual vocabulary
[C] = vl_kmeans(feature_matrix,vocab_size,'MaxNumIterations',100);

% Transpose to get correct columns
C = C';

disp('Quantize the features of all the different images')
% Step 3: Quantize features using vocabulary
[data, label_air, label_car, label_face, label_bike] = feature_quantizer(imd_train, vocab_size, feature_method, C);

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

[data_test, test_air, test_car, test_face, test_bike, file_loc] = test_quantizer(imd_test, vocab_size, feature_method, C);

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
    accuracy_all = [];
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
    accuracy_all = [acc_air,acc_car,acc_face,acc_bike];
end

% Use the decision variable to calculate the mean average precision.
frac_vocab = length(imd_kmeans_vocab.Labels)/length(imd_train.Labels);
pos_val = sum(test_bike == 1);
neg_val = sum(test_bike == 0);
if strcmp(feature_method,'denseSIFT')
    html_print(air, car, face, bike, 3, 3, feature_method, vocab_size, frac_vocab, pos_val, neg_val, 'Linear', learning_method)
else
    html_print(air, car, face, bike, 'NaN', 'NaN', feature_method, vocab_size, frac_vocab, pos_val, neg_val, 'Linear', learning_method)
end

end 
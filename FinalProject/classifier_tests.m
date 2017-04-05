%% Part 1 extra tests

% Compare classifiers
%disp('Naive Bayes classifier, vocab size 400, SIFT')
%bag_of_words(400, 'SIFT', 'naive-bayes');

%disp('Naive Bayes classifier, vocab size 400, DoG')
%bag_of_words(400, 'DoG', 'naive-bayes');

%disp('Naive Bayes classifier, vocab size 400, RGBSIFT')
%bag_of_words(400, 'RGBSIFT', 'naive-bayes');

disp('K-means classifier, vocab size 400, SIFT')
bag_of_words(400, 'SIFT', 'k-means');

disp('K-means classifier, vocab size 400, DoG')
bag_of_words(400, 'DoG', 'k-means');

disp('K-means classifier, vocab size 400, RGBSIFT')
bag_of_words(400, 'RGBSIFT', 'k-means');

%disp('Naive Bayes classifier, vocab size 2000, SIFT')
%bag_of_words(400, 'SIFT', 'naive-bayes');

%disp('Naive Bayes classifier, vocab size 2000, DoG')
%bag_of_words(400, 'DoG', 'naive-bayes');

%disp('Naive Bayes classifier, vocab size 2000, RGBSIFT')
%bag_of_words(400, 'RGBSIFT', 'naive-bayes');

disp('K-means classifier, vocab size 2000, SIFT')
bag_of_words(2000, 'SIFT', 'k-means');

disp('K-means classifier, vocab size 2000, DoG')
bag_of_words(2000, 'DoG', 'k-means');

disp('K-means classifier, vocab size 2000, RGBSIFT')
bag_of_words(2000, 'RGBSIFT', 'k-means');

%% Main function for first part.

% Test
bag_of_words(400, 'SIFT', 'k-nearest')

% Find best Vocab size
disp('400, sift')
bag_of_words(400, 'rgbSIFT', 'SVM');

disp('800, sift')
bag_of_words(800, 'SIFT', 'SVM');

disp('1600, sift')
bag_of_words(1600, 'SIFT', 'SVM');

disp('2000, sift')
bag_of_words(2000, 'SIFT', 'SVM');

disp('4000, sift')
bag_of_words(4000, 'SIFT', 'SVM');

% Find the best SIFT type
disp('400, denseSIFT')
bag_of_words(400, 'denseSIFT', 'SVM');

disp('400, HSVSIFT')
bag_of_words(400, 'HSVSIFT', 'SVM');

disp('400, rgbSIFT')
bag_of_words(400, 'rgbSIFT', 'SVM');

disp('400, RGBSIFT')
bag_of_words(400, 'RGBSIFT', 'SVM');

disp('400, opponentSIFT')
bag_of_words(400, 'opponentSIFT', 'SVM');

% OPTIONAL RUNS

% Other feature extraction
disp('400, DoG')
bag_of_words(400, 'DoG', 'SVM');

disp('400, HarrisLaplace')
bag_of_words(400, 'HarrisLaplace', 'SVM');

disp('400, HessianLaplace')
bag_of_words(400, 'HessianLaplace', 'SVM');

% Running all SIFTS with all vocabulary sizes
% 800
disp('800, denseSIFT')
bag_of_words(800, 'denseSIFT', 'SVM');
disp('800, HSVSIFT')
bag_of_words(800, 'HSVSIFT', 'SVM');
disp('800, rgbSIFT')
bag_of_words(800, 'rgbSIFT', 'SVM');
disp('800, RGBSIFT')
bag_of_words(800, 'RGBSIFT', 'SVM');
disp('800, opponentSIFT')
bag_of_words(800, 'opponentSIFT', 'SVM');

% 1600
disp('1600, denseSIFT')
bag_of_words(1600, 'denseSIFT', 'SVM');
disp('1600, HSVSIFT')
bag_of_words(1600, 'HSVSIFT', 'SVM');
disp('1600, rgbSIFT')
bag_of_words(1600, 'rgbSIFT', 'SVM');
disp('1600, RGBSIFT')
bag_of_words(1600, 'RGBSIFT', 'SVM');
disp('1600, opponentSIFT')
bag_of_words(1600, 'opponentSIFT', 'SVM');

% 2000
disp('2000, denseSIFT')
bag_of_words(2000, 'denseSIFT', 'SVM');
disp('2000, HSVSIFT')
bag_of_words(2000, 'HSVSIFT', 'SVM');
disp('2000, rgbSIFT')
bag_of_words(2000, 'rgbSIFT', 'SVM');
disp('2000, RGBSIFT')
bag_of_words(2000, 'RGBSIFT', 'SVM');
disp('2000, opponentSIFT')
bag_of_words(2000, 'opponentSIFT', 'SVM');

% 4000
disp('4000, denseSIFT')
bag_of_words(4000, 'denseSIFT', 'SVM');
disp('4000, HSVSIFT')
bag_of_words(4000, 'HSVSIFT', 'SVM');
disp('4000, rgbSIFT')
bag_of_words(4000, 'rgbSIFT', 'SVM');
disp('4000, RGBSIFT')
bag_of_words(4000, 'RGBSIFT', 'SVM');
disp('4000, opponentSIFT')
bag_of_words(4000, 'opponentSIFT', 'SVM');

% Run HSVSIFT (extra SIFT)
disp('400, HSVSIFT')
bag_of_words(400, 'HSVSIFT', 'SVM');
disp('800, HSVSIFT')
bag_of_words(800, 'HSVSIFT', 'SVM');
disp('1600, HSVSIFT')
bag_of_words(1600, 'HSVSIFT', 'SVM');
disp('2000, HSVSIFT')
bag_of_words(2000, 'HSVSIFT', 'SVM');
disp('4000, HSVSIFT')
bag_of_words(4000, 'HSVSIFT', 'SVM');
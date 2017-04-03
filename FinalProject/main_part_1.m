
%% Main function for first part.

% Test
disp('400, test')
bag_of_words(400, 'CovDet')

% Find best Vocab size
disp('400, sift')
bag_of_words(400, 'rgbSIFT');

disp('800, sift')
bag_of_words(800, 'SIFT');

disp('1600, sift')
bag_of_words(1600, 'SIFT');

disp('2000, sift')
bag_of_words(2000, 'SIFT');

disp('4000, sift')
bag_of_words(4000, 'SIFT');

% Find the best SIFT type
disp('400, denseSIFT')
bag_of_words(400, 'denseSIFT');

disp('400, HSVSIFT')
bag_of_words(400, 'HSVSIFT');

disp('400, rgbSIFT')
bag_of_words(400, 'rgbSIFT');

disp('400, RGBSIFT')
bag_of_words(400, 'RGBSIFT');

disp('400, opponentSIFT')
bag_of_words(400, 'opponentSIFT');

% OPTIONAL RUNS

% Running all SIFTS with all vocabulary sizes
% 800
disp('800, denseSIFT')
bag_of_words(800, 'denseSIFT');
disp('800, HSVSIFT')
bag_of_words(800, 'HSVSIFT');
disp('800, rgbSIFT')
bag_of_words(800, 'rgbSIFT');
disp('800, RGBSIFT')
bag_of_words(800, 'RGBSIFT');
disp('800, opponentSIFT')
bag_of_words(800, 'opponentSIFT');

% 1600
disp('1600, denseSIFT')
bag_of_words(1600, 'denseSIFT');
disp('1600, HSVSIFT')
bag_of_words(1600, 'HSVSIFT');
disp('1600, rgbSIFT')
bag_of_words(1600, 'rgbSIFT');
disp('1600, RGBSIFT')
bag_of_words(1600, 'RGBSIFT');
disp('1600, opponentSIFT')
bag_of_words(1600, 'opponentSIFT');

% 2000
disp('2000, denseSIFT')
bag_of_words(2000, 'denseSIFT');
disp('2000, HSVSIFT')
bag_of_words(2000, 'HSVSIFT');
disp('2000, rgbSIFT')
bag_of_words(2000, 'rgbSIFT');
disp('2000, RGBSIFT')
bag_of_words(2000, 'RGBSIFT');
disp('2000, opponentSIFT')
bag_of_words(2000, 'opponentSIFT');

% 4000
disp('4000, denseSIFT')
bag_of_words(4000, 'denseSIFT');
disp('4000, HSVSIFT')
bag_of_words(4000, 'HSVSIFT');
disp('4000, rgbSIFT')
bag_of_words(4000, 'rgbSIFT');
disp('4000, RGBSIFT')
bag_of_words(4000, 'RGBSIFT');
disp('4000, opponentSIFT')
bag_of_words(4000, 'opponentSIFT');

% Run HSVSIFT (extra SIFT)
disp('400, HSVSIFT')
bag_of_words(400, 'HSVSIFT');
disp('800, HSVSIFT')
bag_of_words(800, 'HSVSIFT');
disp('1600, HSVSIFT')
bag_of_words(1600, 'HSVSIFT');
disp('2000, HSVSIFT')
bag_of_words(2000, 'HSVSIFT');
disp('4000, HSVSIFT')
bag_of_words(4000, 'HSVSIFT');


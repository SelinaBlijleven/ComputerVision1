
%% Main function for first part.

% Find best Vocab size
disp('400, sift')
bag_of_words(400, 'rgbSIFT');

disp('800, sift')
bag_of_words(800, 'SIFT');

disp('1600, sift')
bag_of_words(1600, 'SIFT');

% Find the best SIFT type
disp('400, denseSIFT')
bag_of_words(400, 'denseSIFT');

disp('400, HSVSIFT')
bag_of_words(400, 'HSVSIFT');

disp('400, RGBSIFT')
bag_of_words(400, 'RGBSIFT');

disp('400, opponentSIFT')
bag_of_words(400, 'opponentSIFT');
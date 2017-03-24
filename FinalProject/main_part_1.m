function main_part_1()
%% Main function for first part.

% Find best Vocab size
bag_of_words(400, 'SIFT')
bag_of_words(800, 'SIFT')
bag_of_words(1600, 'SIFT')

% Find the best SIFT type
bag_of_words(400, 'SIFT')
bag_of_words(400, 'denseSIFT')
bag_of_words(400, 'HSVSIFT')
bag_of_words(400, 'RGBSIFT')
bag_of_words(400, 'opponentSIFT')



end

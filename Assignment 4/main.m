%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

% Alignment images
align1 = imread(rgb2gray('boat1.pgm'));
align2 = imread(rgb2gray('boat2.pgm'));

% Stitching images
stitch1 = imread(rgb2gray('left.jpg'));
stitch2 = imread(rgb2gray('right.jpg'));

%%%%%%%%%%%%%
% Alignment %
%%%%%%%%%%%%%

alignment = Image_alignment(align1, align2);
imshow(alignment)

% How many iterations in average are needed to ?nd good transformation parameters?


%%%%%%%%%%%%%
% Stitching %
%%%%%%%%%%%%%

stitching = Image_stitching(stitch1, stitch2);
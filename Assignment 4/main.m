%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

% Alignment images
align1 = single(imread('boat1.pgm'));
align2 = single(imread('boat2.pgm'));

% Stitching images
stitch1 = rgb2gray(imread('left.jpg'));
stitch2 = rgb2gray(imread('right.jpg'));

%%%%%%%%%%%%%
% Alignment %
%%%%%%%%%%%%%

% alignment = Image_alignment(align1, align2);
% imshow(alignment, [min(min(alignment)),max(max(alignment))]);

% How many iterations in average are needed to ?nd good transformation parameters?


%%%%%%%%%%%%%
% Stitching %
%%%%%%%%%%%%%

stitching = Image_stitching(stitch1, stitch2);
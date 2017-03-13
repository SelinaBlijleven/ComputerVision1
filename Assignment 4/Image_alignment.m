function Aligned = Image_alignment(image_1 , image_2)
%% Aligns two images with an affine transformation
% Input:
% Two images that can be aligned.

% Iterations of RANSAC
N = 10;
% Amount of matches to sample
P = 10;

% Detect interest points in each image
% Characterize the local appearance of the regions around interest points.
[f_1,d_1] = vl_sift(image_1);
[f_2,d_2] = vl_sift(image_2);

h1 = vl_plotframe(f_1(:,1:50)) ;
set(h1,'color','k','linewidth',3) ;

% Get the set of supposed matches between region descriptors in each image.
[matches, scores] = vl_ubcmatch(d_1, d_2);

% Perform RANSAC to discover the best transformation between images.


end
function A, b = lucas-kanade_algorithm(image1, image2)
% Lucas-Kanade Algorithm for estimating optical flow.
% Estimated as v = (A^T A)^-1 A^Tb. 

% Input:
% image1: First image
% image2: Second image

% Output:
% A: Matrix used for estimating optical flow.
% b: Vector used for estimating optical flow.

% Divide input images on non-overlapping regions, each region being 15×15 
% pixels.

% For each region compute A, AT and b; then estimate optical ?ow as given 
% in equation (20).

% When you have estimation for optical ?ow (Vx,Vy) of each region, you 
% should display the results. There is a matlab function quiver which 
% plots a set of two-dimensional vectors as arrows on the screen. 
% Try to ?gure out how to use this to plot your optical ?ow results.


end
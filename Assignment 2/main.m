function main ()
%% Running of the complete assignment

% loading all the images.
image_1 = imread('Images\image1.jpeg');
image_2 = imread('Images\image2.jpeg');
image_3 = imread('Images\image3.jpeg');
image_4 = imread('Images\image4.jpeg');
input_im = imread('Images\input.png');
reference_im = imread('Images\reference.png');
unsharp_im = imread('Images\unsharp.jpeg');

% Assignment 2.1 Box filter
imOut_2_1 = denoise(image_2, 'Box', 5);
figure;
imshow(imOut_2_1, [min(min(imOut_2_1)),max(max(imOut_2_1))]);

% Assignment 2.1 Median filter
imOut_2_1 = denoise(image_2, 'Median', 5);
figure;
imshow(imOut_2_1, [min(min(imOut_2_1)),max(max(imOut_2_1))]);

% Assignment 2.2 Histogram Matching
imOut_2_2 = myHistMatching(input_im, reference_im);

% Assignment 2.3 Computation of the Gradient
% PROBLEM: PLOT of the im_direction does not work correctly.
[im_magnitude_2_3 , im_direction_2_3] = compute_gradient(image_3);

% Assignment 2.4 Unsharp masking with sigma = 1, kernel_size = 5, k = 1
imOut_2_4 = unsharp(image_4 , 1 , 5, 1);
figure;
imshow(imOut_2_4, [min(min(imOut_2_4)),max(max(imOut_2_4))]);

% Assignment 2.5 Computation of the Laplacian of Gaussian.
imOut_2_5 = compute_LoG(image_1 , LOG_type);




end
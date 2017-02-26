function imOut = unsharp (image , sigma , kernel_size , k)
%% Unsharp masking
% Is an image sharpening technique that uses a gaussian kernel to create a
% mask of the image.
% Input:
% image = is the image that is used to unsharp.
% sigma = the standard deviation of the gaussian kernel.
% kernel_size = is the kernel size of the gaussian kernel.
% k = is the sharpness factor. It controls the overshoot of the image
% sharpness.

% creation of the kernel, with the help of our own gaussian kernel.
imSmooth = gaussConv(image, sigma, sigma, kernel_size);

% Calculation of the Highpassed image.
HighPassed = double(image) - imSmooth;

% Multplication of the Highpassed image with the sharpness factor.
HighPassed = HighPassed * k;

% Return of the unsharped image.
imOut = double(image) + HighPassed;
end
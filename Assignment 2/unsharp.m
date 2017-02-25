function imOut = unsharp (image , sigma , kernel_size , k)
%% Unsharp masking

% creation of the kernel.

% Own build of the gaussian smoothing
imSmooth = gaussConv(image, sigma, sigma, kernel_size);

HighPassed = double(image) - imSmooth;
HighPassed = HighPassed * k;

imOut = double(image) + HighPassed;
end
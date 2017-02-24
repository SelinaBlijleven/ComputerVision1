function imOut = unsharp (image , sigma , kernel_size , k)
%% Unsharp masking

% creation of the kernel.

% Own build of the gaussian smoothing
imSmooth = gaussConv(image, sigma, sigma, kernel_size);

% Simple build of gaussian smoothing
filter = fspecial('gaussian', kernel_size, sigma);
imSmooth = conv2(image, filter, 'same');

% built-in function gaussian smoothing
Use_built_in = 1;
imSmooth = imgaussfilt(image, sigma, 'FilterSize',5);

if Use_built_in == 1
    HighPassed = image - imSmooth;
    HighPassed = HighPassed * k;


    imOut = image + HighPassed;
else
    HighPassed = double(image) - imSmooth;
    HighPassed = HighPassed * k;


    imOut = double(image) + HighPassed;
end
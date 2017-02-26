function imOut = compute_LoG (image , LOG_type )
%% Compute Laplacian of Gaussian

% Added Constants.
sigma = 1;
sigma_1 = 0.75;
sigma_2 = 1.4;
alpha = 0.5;
kernel_size = 3;

% Method 1: Smoothing the image with a Gaussian operator, 
% then taking the Laplacian of the smoothed image.

if LOG_type == 'Method 1'
    image = im2double(image);
    
    % Filter 1, the Gaussian filter that goes over the image first.
    filter_1 = fspecial('gaussian', kernel_size, sigma);
    imOut = imfilter(image,filter_1);
    % Filter 2, the laplacian filter that goes over the image second.
    filter_2 = fspecial('laplacian', alpha);
    imOut = imfilter(imOut,filter_2);
    
    % Plotting the image
    figure;
    imshow(imOut, [min(min(imOut)),max(max(imOut))]);

end

% Method 2: Convolving the image directly with LoG operator

if LOG_type == 'Method 2'
    image = im2double(image);
    
    % The LoG filter that is applied to the image.
    filter = fspecial('log', kernel_size, sigma);
    imOut = imfilter(image,filter);
    
    % Plotting the image
    figure;
    imshow(imOut, [min(min(imOut)),max(max(imOut))]);
    
end

% Method 3: Taking the difference between two Gaussians (DoG) computed 
% at different scales sigma_1 and sigma_2.

if LOG_type == 'Method 3'
    image = im2double(image);
    
    % The two gaussian functions that are used to calculate the Difference
    % of Gaussians.
    gaussian1 = fspecial('Gaussian', kernel_size, sigma_1);
    gaussian2 = fspecial('Gaussian', kernel_size, sigma_2);
    DoG = gaussian1 - gaussian2;
    
    % Application of the filter.
    imOut = imfilter(image, DoG);
    
    % Plotting the image
    figure;
    imshow(imOut, [min(min(imOut)),max(max(imOut))]);
end

end
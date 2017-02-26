function [ im_magnitude , im_direction ] = compute_gradient ( image )
%% Gradient Magnitude
% This function calculates the gradient of an image, by using an sobel
% filter to find the edges in the image.
% Input:
% Image = the inputted image on which the gradient is calculated.
% Output:
% im_magnitude = the magnitude of the gradient at all points of the image.
% im_direction = the direction of the gradient at all points of the image.

% The kernelsize is always 3.
kernel_size = 3;

% The (Sobel)filter that is used to find the edges in the image.
x_conv = [ -1 0 1;
           -2 0 2;
           -1 0 1];
% The y-filter is the x-fitlert transposed.
y_conv = x_conv';

% The preprocessing of the image so that the size is known and the image is
% padded with zeroes.
[xdim, ydim] = size(image);
image = padarray(image,floor(kernel_size/2));

%Preallocation of the imOut_X.
imOut_X = zeros(xdim, ydim);

% Actual looping over the image, starting with the first kernel_size pixels
% of the image. Looping the gradient over the Y-direction.
for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
    for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
        % Get the Correct group of pixels for the kernel calculation.
        neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
        
        % Looping over the convolution. where the each pixel is multiplied
        % by the corresponding kernelvalue and than summed up. and assigned
        % to the right location in the new output image, imOut.
        value_summed = 0;
        for elem_x=1:kernel_size
           for elem_y=1:kernel_size

               value_summed = value_summed + double(neighbors(elem_x, elem_y)).*x_conv(elem_x, elem_y);
           end
        end
        imOut_X(x,y) = value_summed;
    end
end

% The plotting of the image with respect to the x-direction.
figure;
imshow(imOut_X, [min(min(imOut_X)),max(max(imOut_X))]);

%Preallocation of the imOut_Y.
imOut_Y = zeros(xdim, ydim);

% Actual looping over the image, starting with the first kernel_size pixels
% of the image. Looping the gradient over the Y-direction.
for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
    for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
        % Get the Correct group of pixels for the kernel calculation.
        neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
        
        % Looping over the convolution. where the each pixel is multiplied
        % by the corresponding kernelvalue and than summed up. and assigned
        % to the right location in the new output image, imOut_Y.
        value_summed = 0;
        for elem_x=1:kernel_size
           for elem_y=1:kernel_size
               value_summed = value_summed + double(neighbors(elem_x, elem_y)).*y_conv(elem_x, elem_y);
           end
        end
        imOut_Y(x,y) = value_summed;
    end
end

% The plotting of the image with respect to the y-direction.
figure;
imshow(imOut_Y, [min(min(imOut_Y)),max(max(imOut_Y))]);

% The preallocation of the image difference in magnitude.
im_magnitude = zeros(xdim,ydim);

% This loop moves over the image gradient in x-direction over the image
% gradient in y-direction and calculates the magnitude of the image, by
% calculating the total euclidian distance of the vector.

for x=1:xdim %loop in x-dimension
    for y=1:ydim % loop in y-dimension
        magnitude = sqrt(imOut_X(x,y).^2+ imOut_Y(x,y).^2);
        im_magnitude(x,y) = magnitude;
    end
end

figure;
imshow(im_magnitude, [min(min(im_magnitude)),max(max(im_magnitude))]);

% Direction does not work correctly.
im_direction = zeros(xdim,ydim);

% This loop moves over the image gradient in x-direction over the image
% gradient in y-direction and calculates the direction of gradient of the
% image. by using the inverse tangent to calculate the angle.
for x=2:xdim %loop in x-dimension
    for y=2:ydim % loop in y-dimension
        direction = atan(imOut_X(x,y)./ imOut_Y(x,y));
        im_direction(x,y) = direction;
    end
end

% Plotting the imagegradient angle.
figure;
imshow(im_direction, [min(min(im_direction)),max(max(im_direction))]);



end
function imOut = gaussConv (image , sigma_x , sigma_y , kernel_size )
%% Gaussian Convolution 2d
% This function uses a Gaussian kernel to move over an image and returns
% the convolved image.
% Image - is the input image that has to be convolved.
% Sigma_x is the standard deviation in the x direction.
% Sigma_y is the standard deviation in the y direction.
% Kernel_size is the size of the square kernel.
% Imout is the convolved output image.

% Builds the x and y values of the kernel that are needed to calculate the
% Gaussian kernel.
support = linspace(ceil(-kernel_size/2), floor(kernel_size/2), kernel_size);
[X,Y] = meshgrid(support,support);

% Actual calculation of the Gaussian kernel.
G = exp( -(X.^2)/(2*sigma_x^2)+(Y.^2)/(2*sigma_y^2) );

% Making sure that the filter has no larger sum than 1.
Filter = G / sum(G(:));

% The preprocessing of the image so that the size is known and the image is
% padded with zeroes.
[xdim, ydim] = size(image);
image = padarray(image,floor(kernel_size/2));

%Preallocation of the imOut.
imOut = zeros(xdim, ydim);

% Actual looping over the image, starting with the first kernel_size pixels
% of the image.
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
               value_summed = value_summed + double(neighbors(elem_x, elem_y))*Filter(elem_x, elem_y);
           end
        end
        imOut(x,y) = round(value_summed);
    end
end


end
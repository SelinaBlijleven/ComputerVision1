function imOut = denoise(image , kernel_type , kernel_size)
%% Denoise function:
% denoises stuff.
% Image         =   The image that has to be denoised.
% kernel_type   =   The type of kernel, "Box" or "Median"
% kernel_size   =   The kernel size: 3x3, 5x5, or 7x7, (Box extra 9x9)

% Making sure that the kernelsize is conform with the standard that has
% been put up.
A = [3 5 7 9];
A = any(A(:) == kernel_size);
B = [3 5 7];
B = any(B(:) == kernel_size);

% box filtering
if strcmp(kernel_type,'Box')  && A
    % The build of the Box filter.
    filter = ones(kernel_size,kernel_size)*(1/(kernel_size^2));
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
            for elem_x=1:kernel_size
               for elem_y=1:kernel_size
                   value_summed = value_summed + double(neighbors(elem_x, elem_y))*filter(elem_x, elem_y);
               end
            end
            imOut(x,y) = value_summed;
        end
    end

% Median filtering
elseif strcmp(kernel_type,'Median') && B
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
            imOut(x,y) = median(neighbors(:));
        end
    end
    
else
    % If the size or the kernel is incorrectly specified return this.
    print('wrong kernel or kernel size');
    return
end
end
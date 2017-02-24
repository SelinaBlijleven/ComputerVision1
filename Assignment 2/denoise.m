function imOut = denoise(image , kernel_type , kernel_size)
%% Denoise function:
% denoises stuff.
% Image         =   The image that has to be denoised.
% kernel_type   =   The type of kernel, "Box" or "Median"
% kernel_size   =   The kernel size: 3x3, 5x5, or 7x7, (Box extra 9x9)
A = [3 5 7 9];
A = any(A(:) == kernel_size);
B = [3 5 7];
B = any(B(:) == kernel_size);

% box filtering
if strcmp(kernel_type,'Box')  && A
    filter = ones(kernel_size,kernel_size);
    filter = filter*(1/(kernel_size^2));
    imOut = conv2(image,filter);

% Median filtering
elseif strcmp(kernel_type,'Median') && B
    [xdim, ydim] = size(image);
    imOut = zeros(xdim, ydim);
    image = padarray(image,floor(kernel_size/2));
    
    for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
        for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
            neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
            imOut(x,y) = median(neighbors(:));
        end
    end
    
else
    print('wrong kernel or kernel size');
    return
end
end
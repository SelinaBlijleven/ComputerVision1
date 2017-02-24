function imOut = denoise(image , kernel_type , kernel_size)
%% Denoise function:
% denoises stuff.
% Image         =   The image that has to be denoised.
% kernel_type   =   The type of kernel, "Box" or "Median"
% kernel_size   =   The kernel size: 3x3, 5x5, or 7x7, (Box extra 9x9)


% box filtering
if (kernel_type == 'Box') && (any(kernel_size , [3,5,7,9]))
    filter = ones(kernel_size,kernel_size);
    filter = filter*(1/(kernel_size^2));
    imOut = conv2(image,filter);

% Median filtering
elseif (kernel_type == 'Median') && (any(kernel_size , [3,5,7]))
    filter = @(x) median(x(:));
    imOut = nlfilter(image, [kernel_size, kernel_size], filter);
    
else
    print('wrong kernel or kernel size');
    return
end

end
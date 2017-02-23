function imOut = denoise(image , kernel_type , kernel_size)
%% Denoise function:
% denoises stuff.
% Image         =   The image that has to be denoised.
% kernel_type   =   The type of kernel, "Box" or "Median"
% kernel_size   =   The kernel size: 3x3, 5x5, or 7x7, (gaussian extra 9x9)


% box filtering
if kernel_type = 'Box'
    filter = ones(kernel_size,kernel_size);
    filter = filter*(1/(kernel_size^2));
    imOut = conv2(image,filter);
end


% Median filtering
if kernel_type = 'Median'
    imOut = medfilt2(image, [kernel_size kernel_size]) ;
end

end
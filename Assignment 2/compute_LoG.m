function imOut = compute_LoG (image , LOG_type )
%% Compute Laplacian of Gaussian

% Method 1: Smoothing the image with a Gaussian operator, 
% then taking the Laplacian of the smoothed image.

sigma = 1;
kernel_size = 5;

if LOG_type == 'Method 1'
    imOut_1 = gaussConv (image , sigma , sigma , kernel_size );
    
    
    
end

% Method 2: Convolving the image directly with LoG operator

if LOG_type == 'Method 2'
    
    
    
    
end

% Method 3: Taking the di?erence between two Gaussians (DoG) computed 
% at di?erent scales ?1 and ?2.

if LOG_type == 'Method 3'
    
    
    
    
end



end
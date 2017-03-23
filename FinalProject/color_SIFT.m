function [f, d] = color_SIFT(image, colorspace)
    % This functions performs feature extraction in HSV or RGB color space
    
    % Input
    % Image: The image to use SIFT on
    % Colorspace: Desired colorspace
    
    % Initialize empty features + descriptors
    f = [];
    d = [];
    
    % Get image size
    [m, n, dim] = size(image);
    
    % RGB image is required for colorSIFT, give error if too little dimensions 
    % are found.
    if dim < 3
        disp('Image not recognized as RGB. Please make sure your image is 3-dimensional.')
        return
    end
        
    % Convert to HSV space if desired.
    if colorspace == 'HSV'
        image = rgb2hsv(image);
    end
    
    % Extract keypoints from single channel.
    [f, single_d] = vl_sift(reduce_dimension(image));
    
    % Extract descriptors for every dimension and concatenate.
    for i=1:d
        [dim_f, dim_d] = vl_sift(single(image(:, :, i)));
        size(dim_d)
        d = [d ; dim_d]
    end
end
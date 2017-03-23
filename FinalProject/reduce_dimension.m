function image = reduce_dimension(image)
    % Some SIFT methods work with grayscale images, others use color.
    % This function converts the image to grayscale if necessary.
    
    % Input
    % Image: RGB/grayscale image
    
    % Output
    % Image: Grayscale image
    
    % Image size
    [m, n, d] = size(image)

    if d > 1
        image = single(rgb2gray(image));
    end
end
function rgb_image = RGB2rgb(image)
    % Function to convert an RGB colorspace image to a normalized rgb 
    % colorspace.
    
    % Input
    % image: RGB image
    
    % Output
    % rgb_image: Input image converted to rgb colorspace
    
    % Get image size
    [m, n, dim] = size(image);
    
    % Separate RGB channels for calculation
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    % Initialize rgb image
    rgb_image = zeros(m, n, dim);
    
    rgb_image(:, :, 1) = R ./ (R+G+B);
    rgb_image(:, :, 2) = G ./ (R+G+B);
    rgb_image(:, :, 3) = B ./ (R+G+B);
end
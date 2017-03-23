function O = rgb2opponent(image)
    % Function to convert an RGB colorspace image to an opponent colorspace
    % image.
    
    % Input
    % image: RGB image
    
    % Output
    % O: Input image converted to opponent colorspace
    
    % Get image size
    [m, n, dim] = size(image);
    
    % Separate RGB channels for calculation
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    % Initialize opponent image
    O = zeros(m, n, dim);
    
    % Calculate opponent channels
    O(:, :, 1) = (R + G - 2 * B)./ sqrt(2);
    O(:, :, 2) = (R + G - 2 * B)./ sqrt(6);
    O(:, :, 3) = (R + G + B)./ sqrt(3);
    
end
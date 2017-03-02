function [H, r, c, x] = harris_corner_detection(image)
    % Get image size
    [h, w] = size(image);

    % Set kernel size and sigma for Gaussian first order derivative.
    k = 3;
    sigma = 1;
    
    % Set neighbour threshold for corner point detection.
    n = 2;
    
    % Get smoothed derivative of the image in x and y directions.
    [Ix, Iy] = gradient(double(image));
    
    % Get A by squaring Ix and convolving with Gaussian G.
    A = imgaussfilt(Ix^2, sigma);
    
    % Get B somehow magically but for now it's just A
    B = A;
    
    % Get C by squaring Iy and convolving with gaussian G.
    C = imgaussfilt(Iy^2, sigma);
    
    % Use A, B and C to calculate H matrix.
    H = (A * C - power(B, 2)) - 0.04 * power((A + C), 2);
    
    [r, c] = detect_corners(H, n);
    
    % Show image derivatives
    figure;
    imshow(Ix);
    
    figure;
    imshow(Iy);
    
    % Show original image
    figure;
    imshow(image)
    hold on;
    
    % Plot corner points.
    plot(c, r, 'r.')
end
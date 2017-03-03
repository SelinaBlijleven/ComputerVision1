function [H, r, c] = harris_corner_detection(image)
    % Uses Harris method for corner detection. A help function for this
    % algorithm is defined in detect_corners.m.
    
    % Input:
    % image: Initial image for corner detection
    
    % Output:
    % H: Cornerness matrix
    % r: Row coordinates of detected corners
    % c: Column coordinates of detected corners

    % Get image size
    [h, w] = size(image);

    % Set kernel size and sigma for Gaussian first order derivative.
    k = 3;
    sigma = 1;
    
    % Set neighbour threshold for corner point detection.
    n = 2;
    
    % Get smoothed derivative of the image in x and y directions.
    [Ix, Iy] = gradient(double(image));           % first order partials

    % Get A by squaring Ix and convolving with Gaussian G.
    filter = fspecial('gaussian', k, sigma);
    A = imfilter(Ix.^2, filter);
    
    % Get B somehow magically but for now it's just A
    B = imfilter(Ix.*Iy, filter);
    
    % Get C by squaring Iy and convolving with gaussian G.
    C = imfilter(Iy.^2, filter);
    H = zeros(h,w);
    
    % Use A, B and C to calculate H matrix.
    for y = 1:w  % column
        for x = 1:h    % row
            H(x,y) = (A(x,y) * C(x,y) - power(B(x,y), 2)) - 0.04 * power((A(x,y) + C(x,y)), 2);
        end
    end
    % Get rows and columns of detected corners.
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
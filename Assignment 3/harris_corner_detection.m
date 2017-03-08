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
    k = 10;
    sigma = 1;
    constant = 97;
    
    % Set neighbour threshold for corner point detection.
    n = 3;

    % Get smoothed derivative of the image in x and y directions.
    [Ix, Iy] = gradient(double(image)); 
    
    % Get A by squaring Ix and convolving with Gaussian G.
    filter = fspecial('gaussian', k, sigma);
    A = conv2(Ix.^2, filter, 'same');
    
    % Get B somehow magically but for now it's just A
    B = conv2(Ix.*Iy, filter, 'same');
    
    % Get C by squaring Iy and convolving with gaussian G.
    C = conv2(Iy.^2, filter, 'same');
    
    % Use A, B and C to calculate H matrix.
    H = (A .* C - power(B, 2)) - 0.04 .* power((A + C), 2);
    
    % Get rows and columns of detected corners.
    max=ordfilt2(H,k^2,ones(k));
    threshold = mean(mean(H)) * constant;
    H=(H==max)&(H>threshold);              % Find maxima.
	
	[r, c] = find(H);                      % Find row,col coords.
    
    % [r, c] = detect_corners(H, n);
    
    % Show image derivatives

%     figure;
%     imshow(Ix);
%     
%     figure;
%     imshow(Iy);
%     % Show original image
%     figure;
%     imshow(image)
%     hold on;
%     
%     % Plot corner points.
%     plot(c, r, 'r.')
end
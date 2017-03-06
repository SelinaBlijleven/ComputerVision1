function lucas_kanade_algorithm(image1, image2)
    % Lucas-Kanade Algorithm for estimating optical flow.
    % Estimated as v = (A^T A)^-1 A^Tb. 

    % Input:
    % image1: First image
    % image2: Second image of equal size.

    % Output:
    % A: Matrix used for estimating optical flow.
    % b: Vector used for estimating optical flow.

    % Get size of images.
    [h, w] = size(image1);

    % Set amount of pixels per (square) region.
    pixels = 15;
    Vx = [];
    Vy = [];
    X = [];
    Y = [];

    for x = 1:floor(h/pixels)
        for y = 1:floor(h/pixels)
        % Divide input images on non-overlapping regions, each region being 15×15 
        % pixels.
        x_end = x * pixels + 1;
        y_end = y * pixels + 1;

        region1 = image1((x_end - pixels):x_end, (y_end - pixels):y_end);
        region2 = image2((x_end - pixels):x_end, (y_end - pixels):y_end);

        % For each region compute A, AT and b; then estimate optical ?ow as given 
        % in equation (20).
        Ix1 = conv2(double(region1),[-1 1; -1 1], 'valid'); % partial on x
        Iy1 = conv2(double(region1), [-1 -1; 1 1], 'valid'); % partial on y
        
        % [Ix2, Iy2] = gradient(double(region2));
        
        Ix1 = Ix1(:);
        Iy1 = Iy1(:);
        % Ix2 = Ix2(:);
        % Iy2 = Iy2(:);      
        
        It1_2 = conv2(double(region1), ones(2), 'valid') + conv2(double(region2), -ones(2), 'valid'); % partial on t
        b = -It1_2(:); % get b here
        A1 = [Ix1,Iy1];
        % A2 = [Ix2,Iy2];
        
        AT1 = transpose(A1);
        % AT2 = transpose(A2);

        velocity = inv(AT1*A1)*AT1*b; % get velocity here
        X = [X, x_end-7];
        Y = [Y, y_end-7];
        Vx = [velocity(1), Vx];
        Vy = [velocity(2), Vy];
        % When you have estimation for optical ?ow (Vx,Vy) of each region, you 
        % should display the results. There is a matlab function quiver which 
        % plots a set of two-dimensional vectors as arrows on the screen. 
        % Try to ?gure out how to use this to plot your optical ?ow results.
        end
    end
    
    figure();
    imshow(image2);
    hold on;
    % draw the velocity vectors
    quiver(X, Y, Vx, Vy, 'y')
end
function [r_new, c_new] = lucas_kanade_algorithm(image1, image2, r, c, image_name)
    % Lucas-Kanade Algorithm for estimating optical flow.
    % Estimated as v = (A^T A)^-1 A^Tb. 

    % Input:
    % image1: First image
    % image2: Second image of equal size.

    % Output:
    % A: Matrix used for estimating optical flow.
    % b: Vector used for estimating optical flow.
    if nargin < 3
        % Get size of images.
        [h, w] = size(image1);

        % Set amount of pixels per (square) region.
        pixels = 15;
        Vx = [];
        Vy = [];
        X = [];
        Y = [];


        for x = 1:floor(h/pixels)
            for y = 1:floor(w/pixels)
            % Divide input images on non-overlapping regions, each region being 15×15 
            % pixels.
            x_end = x * pixels;
            y_end = y * pixels;

            region1 = image1((x_end - pixels+1):x_end, (y_end - pixels+1):y_end);
            region2 = image2((x_end - pixels+1):x_end, (y_end - pixels+1):y_end);

            % For each region compute A, AT and b; then estimate optical flow as given 
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

            % AT1 = transpose(A1);
            % AT2 = transpose(A2);

            velocity = A1\b; % get velocity here
            X = [X, x_end-7];
            Y = [Y, y-7];
            Vx = [velocity(1), Vx];
            Vy = [velocity(2), Vy];
            % When you have estimation for optical flow (Vx,Vy) of each region, you 
            % should display the results. There is a matlab function quiver which 
            % plots a set of two-dimensional vectors as arrows on the screen. 
            % Try to ?gure out how to use this to plot your optical flow results.
            end
        end
        figure();
        imshow(image2);
        hold on;
        % draw the velocity vectors
        quiver(X, Y, Vy, Vx, 'y');
    else
        % Get size of images.
        [h, w] = size(image1);

        % Set amount of pixels per (square) region.
        pixels = 15;
        Vx = [];
        Vy = [];
        X = [];
        Y = [];
        r_new = [];
        c_new = [];


        for corner = 1:size(r)
            % Divide input images on non-overlapping regions, each region being 15×15 
            % pixels.
            x = round(c(corner));
            y = round(r(corner));

            if x - floor(pixels/2) < 1
                x = floor(pixels/2) + 1;
            elseif x + floor(pixels/2) > h
                x = h - floor(pixels/2);
            end
            if y - floor(pixels/2) < 1
                y = floor(pixels/2) + 1;
            elseif y + floor(pixels/2) > w
                y = w - floor(pixels/2);
            end

            region1 = image1((x - floor(pixels/2)):(x + floor(pixels/2)), (y - floor(pixels/2)):(y + floor(pixels/2)));
            region2 = image2((x - floor(pixels/2)):(x + floor(pixels/2)), (y - floor(pixels/2)):(y + floor(pixels/2)));

            % For each region compute A, AT and b; then estimate optical ?ow as given 
            % in equation (20).
            % filter = [-1 0 1; -1 0 1; -1 0 1];
            % Ix1 = conv2(double(region1),filter, 'same'); % partial on x
            % Iy1 = conv2(double(region1), filter', 'same'); % partial on y

            [Ix2, Iy2] = gradient(double(region1));

            % Ix1 = Ix1(:);
            % Iy1 = Iy1(:);
            Ix1 = Ix2(:);
            Iy1 = Iy2(:);      

            It1_2 = conv2(double(region1), ones(2), 'same') + conv2(double(region2), -ones(2), 'same'); % partial on t
            b = -It1_2(:); % get b here
 
            A1 = [Ix1,Iy1];
            % A2 = [Ix2,Iy2];

            % AT1 = transpose(A1);
            % AT2 = transpose(A2);

            velocity = A1\b; % get velocity here
            X = [x, X];
            Y = [y, Y];
            Vx = [Vx, velocity(1)];
            Vy = [Vy, velocity(2)];
            r_new = [r_new; r(corner)+velocity(1)];
            c_new = [c_new; c(corner)+velocity(2)];
            
            % When you have estimation for optical flow (Vx,Vy) of each region, you 
            % should display the results. There is a matlab function quiver which 
            % plots a set of two-dimensional vectors as arrows on the screen. 
            % Try to ?gure out how to use this to plot your optical flow results.
        end
        figure();
        imshow(image2);
        hold on;
        % plot the corners
        plot(c, r, 'r.');
        % draw the velocity vectors
        quiver(X, Y, Vy, Vx, 'y');
        saveas(gcf, image_name)
    end
    
end
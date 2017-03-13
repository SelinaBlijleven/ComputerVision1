function transformation = ransac(N, P, T)
    % Input:
    % N: Iterations of ransac
    % P: Amount of samples from T
    % T: Total set of matches

    % Best total inliers
    best_total = 0;
    % Set of inliers for best total inliers
    best_inliers = [];
    % Best transformation parameters
    best_x = [];
    
    % Size of T
    [tm, tn] = size(T);
    % Repeat N times
    for i = 1:N
        
        % Keep track of inliers
        sample_inliers = [];

        % Pick P matches from a total set of matches T
        sample = T(randperm(P), :);

        % Construct a matrix A and vector b using the P pairs of points and 
        % find transformation parameters
        elem_coor = sample(1, 1:2);
        A = [elem_coor(1) elem_coor(2) 0 0 1 0; 0 0 elem_coor(1) elem_coor(2) 0 1];
        b = sample(1, 3:4)';
        x = pinv(A) * b;
        
        % Transform all locations of T points
        % Count the number of inliers, inliers being de?ned as the number of 
        % transformed points from image1 that lie within a radius of 10 pixels 
        % of their pair in image2. 
        for j = 1:size(T)
            elem_coor_T = T(j, 1:2);
            T_A = [elem_coor_T(1) elem_coor_T(2) 0 0 1 0; 0 0 elem_coor_T(1) elem_coor_T(2) 0 1];
            T_b = T(j, 3:4)';
            estimate_b = T_A * x;
            if abs(T_b - estimate_b)
                sample_inliers = [sample_inliers;T(i, :)];
            end
        end
        sample_total = size(sample_inliers);

        % If this count exceeds the best total so far, save the transformation parameters and the set of inliers.
        if sample_total > best_total
            best_total = sample_total;
            best_inliers = sample_inliers;
            best_x = x;
        end
    end

    % Finally, transform image1 using this final set of transformation parameters. 
    % If you display this image you should find that the pose of the object 
    % in the scene should correspond to its pose in image2. To transform 
    % the image, implement your own function based on nearest-neighbor interpolation. 
    % Then use the built-in MATLAB functions imtransform and maketform and compare your results.
    transformation = best_x
end

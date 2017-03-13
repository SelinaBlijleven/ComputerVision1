function Stitched = Image_stitching(image_1 , image_2)
    %% Stitching function that takes two images and stitches them together.
    % N: Iterations of ransac
    N = 100;
    
    % Detection of the keypoints.
    [f_1,d_1] = vl_sift(single(image_1));
    [f_2,d_2] = vl_sift(single(image_2));

    % Get the set of supposed matches between region descriptors in each image.
    [matches, scores] = vl_ubcmatch(d_1, d_2);
    
 
    % Creation of the X, Y and Z coordinates of the matched keypoints
    X1 = f_1(1:2,matches(1,:)) ; X1(3,:) = 1;
    X2 = f_2(1:2,matches(2,:)) ; X2(3,:) = 1;

    for elem_t = 1:N
      % estimate homograpyh
      
      % Subset of 4 matched points:
      subset = vl_colsubset(1:size(matches,2), 4);
      % Creation of Matrix A For the calculation of H
      A = [];
      for i = subset
        A = cat(1, A, kron(X1(:,i)', vl_hat(X2(:,i))));
      end
      
      % Use svd to calculate.
      [U,S,V] = svd(A);
      Homegraph{elem_t} = reshape(V(:,9),3,3);

      % score homography by projecting the points to the matching pair.
      X2_ = Homegraph{elem_t} * X1;
      distance_x = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:);
      distance_y = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:);
      
      % Locate the sum of inliers for the matrix
      inlier{elem_t} = (distance_x.*distance_x + distance_y.*distance_y) < 6*6;
      score(elem_t) = sum(inlier{elem_t});
    end
    
    % locate the best H.
    [score, best] = max(score);
    Homegraph = Homegraph{best};
    
    % Calculate the size of the combined image.
    dh1 = max(size(image_2,1)-size(image_1,1),0);
    dh2 = max(size(image_1,1)-size(image_2,1),0);
    
    % Plot the feature points of the two images that are connected.
    figure();
    imshow([padarray(image_1,dh1,'post') padarray(image_2,dh2,'post')]);
    o = size(image_1,2);
    line([f_1(1,matches(1,:));f_2(1,matches(2,:))+o], [f_1(2,matches(1,:));f_2(2,matches(2,:))]);
    axis image off;
    drawnow;
    
    % Designing the complete box in which the new image will be build.
    x_range = 1:size(image_1,2)+size(image_2,2);
    y_range = 1:size(image_1,1);

    [x,y] = meshgrid(x_range,y_range);
    image_1_ = vl_imwbackward(im2double(image_1),x,y);
    
    % calculation of the new coordinates of the new image. 
    z_ =  Homegraph(3,1) * x + Homegraph(3,2) * y + Homegraph(3,3) ;
    x_ = (Homegraph(1,1) * x + Homegraph(1,2) * y + Homegraph(1,3)) ./ z_ ;
    y_ = (Homegraph(2,1) * x + Homegraph(2,2) * y + Homegraph(2,3)) ./ z_ ;
    image_2_ = vl_imwbackward(im2double(image_2),x_,y_) ;
    
    % locate all the patches that have neither one or the other image
    % values and make them black
    mass = ~isnan(image_1_) + ~isnan(image_2_);
    image_1_(isnan(image_1_)) = 0;
    image_2_(isnan(image_2_)) = 0;
    
    % average the the sum of the parts of the images that have more than
    % one value.
    Stitched = (image_1_ + image_2_) ./ mass;

    figure();
    imshow(Stitched) ;
    title('stitched mage') ;



end
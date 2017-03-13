function Stitched = Image_stitching(image_1 , image_2)
    %% Stitching function that takes two images and stitches them together.
    % N: Iterations of ransac
    N = 100;

    [f_1,d_1] = vl_sift(single(image_1));
    [f_2,d_2] = vl_sift(single(image_2));

    % Get the set of supposed matches between region descriptors in each image.
    [matches, scores] = vl_ubcmatch(d_1, d_2);

    X1 = f_1(1:2,matches(1,:)) ; X1(3,:) = 1 ;
    X2 = f_2(1:2,matches(2,:)) ; X2(3,:) = 1 ;

    for elem_t = 1:N
      % estimate homograpyh
      subset = vl_colsubset(1:size(matches,2), 4) ;
      A = [] ;
      for i = subset
        A = cat(1, A, kron(X1(:,i)', vl_hat(X2(:,i)))) ;
      end
      [U,S,V] = svd(A) ;
      Homegraph{elem_t} = reshape(V(:,9),3,3) ;

      % score homography
      X2_ = Homegraph{elem_t} * X1 ;
      distance_x = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:) ;
      distance_y = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:) ;
      inlier{elem_t} = (distance_x.*distance_x + distance_y.*distance_y) < 6*6 ;
      score(elem_t) = sum(inlier{elem_t}) ;
    end

    [score, best] = max(score) ;
    Homegraph = Homegraph{best} ;

    dh1 = max(size(image_2,1)-size(image_1,1),0) ;
    dh2 = max(size(image_1,1)-size(image_2,1),0) ;

    figure();
    imshow([padarray(image_1,dh1,'post') padarray(image_2,dh2,'post')]) ;
    o = size(image_1,2) ;
    line([f_1(1,matches(1,:));f_2(1,matches(2,:))+o], [f_1(2,matches(1,:));f_2(2,matches(2,:))]) ;
    axis image off ;
    drawnow ;


    box2 = [1   size(image_2,2)  size(image_2,2)     1 ;
            1   1                size(image_2,1)     size(image_2,1) ;
            1   1                1                   1 ] ;

    box2_inv = Homegraph \ box2 ;
    box2_inv(1,:) = box2_inv(1,:) ./ box2_inv(3,:) ;
    box2_inv(2,:) = box2_inv(2,:) ./ box2_inv(3,:) ;
    ur = min([1 box2_inv(1,:)]):max([size(image_1,2) box2_inv(1,:)]) ;
    vr = min([1 box2_inv(2,:)]):max([size(image_1,1) box2_inv(2,:)]) ;

    [u,v] = meshgrid(ur,vr) ;
    image_1_ = vl_imwbackward(im2double(image_1),u,v) ;

    z_ =  Homegraph(3,1) * u + Homegraph(3,2) * v + Homegraph(3,3) ;
    u_ = (Homegraph(1,1) * u + Homegraph(1,2) * v + Homegraph(1,3)) ./ z_ ;
    v_ = (Homegraph(2,1) * u + Homegraph(2,2) * v + Homegraph(2,3)) ./ z_ ;
    image_2_ = vl_imwbackward(im2double(image_2),u_,v_) ;

    mass = ~isnan(image_1_) + ~isnan(image_2_) ;
    image_1_(isnan(image_1_)) = 0 ;
    image_2_(isnan(image_2_)) = 0 ;
    Stitched = (image_1_ + image_2_) ./ mass ;

    figure();
    imshow(Stitched) ;
    title('stitched mage') ;



end
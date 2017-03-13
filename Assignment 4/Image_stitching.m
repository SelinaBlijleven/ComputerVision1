function Stitched = Image_stitching(image_1 , image_2)

% im_2_aligned = Image_alignment(single(image_1) , single(image_2));

[f_1,d_1] = vl_sift(single(image_1));
[f_2,d_2] = vl_sift(single(image_2));
% [f_2,d_2] = vl_sift(im_2_aligned); 

% Get the set of supposed matches between region descriptors in each image.
[matches, scores] = vl_ubcmatch(d_1, d_2);

X1 = f_1(1:2,matches(1,:)) ; X1(3,:) = 1 ;
X2 = f_2(1:2,matches(2,:)) ; X2(3,:) = 1 ;

clear H score ok ;
for t = 1:100
  % estimate homograpyh
  subset = vl_colsubset(1:size(matches,2), 4) ;
  A = [] ;
  for i = subset
    A = cat(1, A, kron(X1(:,i)', vl_hat(X2(:,i)))) ;
  end
  [U,S,V] = svd(A) ;
  H{t} = reshape(V(:,9),3,3) ;

  % score homography
  X2_ = H{t} * X1 ;
  du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:) ;
  dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:) ;
  ok{t} = (du.*du + dv.*dv) < 6*6 ;
  score(t) = sum(ok{t}) ;
end

[score, best] = max(score) ;
H = H{best} ;
ok = ok{best} ;


dh1 = max(size(image_2,1)-size(image_1,1),0) ;
dh2 = max(size(image_1,1)-size(image_2,1),0) ;

figure(1) ; clf ;
subplot(2,1,1) ;
imshow([padarray(image_1,dh1,'post') padarray(image_2,dh2,'post')]) ;
o = size(image_1,2) ;
line([f_1(1,matches(1,:));f_2(1,matches(2,:))+o], ...
     [f_1(2,matches(1,:));f_2(2,matches(2,:))]) ;
title(sprintf('%d tentative matches', size(matches,2))) ;
axis image off ;

subplot(2,1,2) ;
imshow([padarray(image_1,dh1,'post') padarray(image_2,dh2,'post')]) ;
o = size(image_1,2) ;
line([f_1(1,matches(1,ok));f_2(1,matches(2,ok))+o], ...
     [f_1(2,matches(1,ok));f_2(2,matches(2,ok))]) ;
title(sprintf('%d (%.2f%%) inliner matches out of %d', ...
              sum(ok), ...
              100*sum(ok)/size(matches,2), ...
              size(matches,2))) ;
axis image off ;

drawnow ;


box2 = [1  size(image_2,2) size(image_2,2)  1 ;
        1  1           size(image_2,1)  size(image_2,1) ;
        1  1           1            1 ] ;
box2_ = inv(H) * box2 ;
box2_(1,:) = box2_(1,:) ./ box2_(3,:) ;
box2_(2,:) = box2_(2,:) ./ box2_(3,:) ;
ur = min([1 box2_(1,:)]):max([size(image_1,2) box2_(1,:)]) ;
vr = min([1 box2_(2,:)]):max([size(image_1,1) box2_(2,:)]) ;

[u,v] = meshgrid(ur,vr) ;
image_1_ = vl_imwbackward(im2double(image_1),u,v) ;

z_ = H(3,1) * u + H(3,2) * v + H(3,3) ;
u_ = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z_ ;
v_ = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z_ ;
image_2_ = vl_imwbackward(im2double(image_2),u_,v_) ;

mass = ~isnan(image_1_) + ~isnan(image_2_) ;
image_1_(isnan(image_1_)) = 0 ;
image_2_(isnan(image_2_)) = 0 ;
mosaic = (image_1_ + image_2_) ./ mass ;

figure(2) ; clf ;
imshow(mosaic) ; axis image off ;
title('Mosaic') ;

% Match_coor = zeros(50,2);
% for x=1:50
%     x_coor_im_1 = f_1(matches(x,1));
%     y_coor_im_1 = f_1(matches(x,2));
%     x_coor_im_2 = f_2(matches(x,1));
%     y_coor_im_2 = f_2(matches(x,2));
%     Match_coor(x,:) = [x_coor_im_1-x_coor_im_2,y_coor_im_1-y_coor_im_2];
% end
% start = mean(Match_coor);
% X_start = round(start(1));
% Y_start = round(start(2));
% stitched_image = zeros(X_start+size(im_2_aligned,1),Y_start+size(im_2_aligned,2));
% for x=1:size(stitched_image,1)
%     for y=1:size(stitched_image,2)
%         stitched_image(x,y) = image_1(x,y);
%         if x >= X_start && y >= Y_start
%             stitched_image(x,y) = im_2_aligned(x-X_start, y-Y_start);
%             
%         end
%         
%     end
% end

stitching = mosaic;

end
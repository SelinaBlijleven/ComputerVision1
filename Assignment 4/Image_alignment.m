function Aligned = Image_alignment(image_1 , image_2)
%% Aligns two image, with an affine transformation
% Input:
% Two images that can be alligned.

[f_1,d_1] = vl_sift(image_1);
[f_2,d_2] = vl_sift(image_2);

h1 = vl_plotframe(f_1(:,1:50)) ;
set(h1,'color','k','linewidth',3) ;

[matches, scores] = vl_ubcmatch(d_1, d_2);







end
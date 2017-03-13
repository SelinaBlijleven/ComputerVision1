function Aligned = Image_alignment(image_1 , image_2)
%% Aligns two images with an affine transformation
% Input:
% Two images that can be aligned.

% Iterations of RANSAC
N = 10;
% Amount of matches to sample
P = 10;

% Detect interest points in each image
% Characterize the local appearance of the regions around interest points.
% [f_1,d_1] = vl_sift(image_1);
% [f_2,d_2] = vl_sift(image_2);
% 
% % Get the set of supposed matches between region descriptors in each image.
% [matches, scores] = vl_ubcmatch(d_1, d_2);

f_1 = randi(679,1000,4)';
f_2 = randi(679,1000,4)';
matches = randi(1000,1000,2)';
scores  = 3.*randn(1000,1)';

perm = randperm(size(f_1,2)) ;
sel = perm(1:50) ;
imshow(image_1)
hold on
h1 = vl_plotframe(f_1(:,sel)) ;
h2 = vl_plotframe(f_1(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
hold off


Match_coor = zeros(size(matches,1),4);

f_1 = f_1';
f_2 = f_2';
matches = matches';
scores = scores';
for x=1:size(matches)
    Match_coor(x,:) = [f_1(matches(x,1),1:2),f_2(matches(x,2),1:2)];
end


% Perform RANSAC to discover the best transformation between images.
transformation_matrix = ransac(N, P, Match_coor);
out_image = zeros(size(image_1));

% Transform the second image
for x=1:size(out_image,1)
    for y=1:size(out_image,2)
        A = [x y 0 0 1 0; 0 0 x y 0 1];
        coor_new = A*transformation_matrix;
        x_new = min(max(1,round(coor_new(1))),size(out_image,1));
        y_new = min(max(1,round(coor_new(2))),size(out_image,2));
        out_image(x_new,y_new) = image_2(x,y);
    end
end


figure;
imshow(out_image, [min(min(out_image)),max(max(out_image))]);

end
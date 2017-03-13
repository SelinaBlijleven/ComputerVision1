function Stitched = Image_stitching(image_1 , image_2)
im_2_aligned = Image_alignment(image_1 , image_2);
% 
% [f_1,d_1] = vl_sift(image_1);
% [f_2,d_2] = vl_sift(im_2_aligned); 
% 
% % Get the set of supposed matches between region descriptors in each image.
% [matches, scores] = vl_ubcmatch(d_1, d_2);

f_1 = randi(679,1000,4)';
f_2 = randi(679,1000,4)';
matches = randi(1000,1000,2)';
scores  = 3.*randn(1000,1)';
f_1 = f_1';
f_2 = f_2';
matches = matches';
scores = scores';

Match_coor = zeros(50,2);
for x=1:50
    x_coor_im_1 = f_1(matches(x,1));
    y_coor_im_1 = f_1(matches(x,2));
    x_coor_im_2 = f_2(matches(x,1));
    y_coor_im_2 = f_2(matches(x,2));
    Match_coor(x,:) = [x_coor_im_1-x_coor_im_2,y_coor_im_1-y_coor_im_2];
end
start = mean(Match_coor);
X_start = round(start(1));
Y_start = round(start(2));
stitched_image = zeros(X_start+size(im_2_aligned,1),Y_start+size(im_2_aligned,2));
for x=1:size(stitched_image,1):
    for y=1:size(stitched_image,2):
        stitched_image(x,y) = image_1(x,y);
        if x => X_start && y => Y_start
            stitched_image(x,y) = im_2_aligned(x-X_start, y-Y_start);
            
        end
        
    end
end

end
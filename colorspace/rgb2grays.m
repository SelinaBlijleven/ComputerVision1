function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
output_image = zeros(size(input_image,1),size(input_image,2),4);

% ligtness method
for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        output_image(row,column,1) = (max([R,G,B]) + min([R,G,B]))/2;
    end
end
% average method
for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        output_image(row,column,2) = (R+G+B)/3;
    end
end
% luminosity method
for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        output_image(row,column,3) = 0.21*R+0.72*G + 0.07*B;
    end
end

% built-in MATLAB function 
output_image(:,:,4) = rgb2gray(input_image);
 
end


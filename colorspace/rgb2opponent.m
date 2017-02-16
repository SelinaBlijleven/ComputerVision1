function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
output_image = zeros(size(input_image));

for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        O_1 = (R - G)/sqrt(2);
        O_2 = (R + G - 2*B)/sqrt(6);
        O_3 = (R + G + B)/sqrt(3);
        
        output_image(row, column, :) = [O_1, O_2, O_3];
    end
end
        
end


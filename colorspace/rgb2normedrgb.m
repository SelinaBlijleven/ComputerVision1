function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
output_image = zeros(size(input_image));

for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        sum_values = R + G + B;
        output_image(row, column, :) = [R/sum_values, G/sum_values, B/sum_values];
    end
end
end


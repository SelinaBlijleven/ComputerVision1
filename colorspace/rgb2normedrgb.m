function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
output_image = zeros(size(input_image));

for row = 1:size(input_image, 1)
    for column = 1:size(input_image, 2)
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        sum = sum(output_image(row, column));
        output_image(row, column, :) = [R/sum, G/sum, B/sum];
    end
end
end


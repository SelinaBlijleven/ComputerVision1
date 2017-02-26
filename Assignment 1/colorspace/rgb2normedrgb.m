function [output_image] = rgb2normedrgb(input_image)
%% converts an RGB image into normalized rgb
% This technique converst the RGB colors is proportions of the colors, by
% dividing the RGB values by the sum of the RGB values at that pixel. This
% can be seen as calculating the intensity of the three different colors.

output_image = zeros(size(input_image));

% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Storing the RGB values.
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        sum_values = R + G + B;
        % The normalized RGB values, by calculating the proportions of the
        % colors.
        output_image(row, column, :) = [R/sum_values, G/sum_values, B/sum_values];
    end
end
end


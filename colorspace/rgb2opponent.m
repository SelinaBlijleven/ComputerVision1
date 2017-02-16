function [output_image] = rgb2opponent(input_image)
%% converts an RGB image into opponent colorspace. 
% This technique is based on the processing signals the brain uses to 
% interpret the information that the different colors have.
output_image = zeros(size(input_image));

% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Storing the RGB values.
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        
        % The opponent colorspace has three components:
        % O_1 is the red-green channel:
        O_1 = (R - G)/sqrt(2);
        % O_2 is luminance component:
        O_2 = (R + G - 2*B)/sqrt(6);
        % O_3 is the blue-yellow channel:
        O_3 = (R + G + B)/sqrt(3);
        
        output_image(row, column, :) = [O_1, O_2, O_3];
    end
end
        
end


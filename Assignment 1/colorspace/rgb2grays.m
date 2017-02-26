function [output_image] = rgb2grays(input_image)
%% converts an RGB into grayscale by using 4 different methods.

% The four different methods are stored in a single 3d matrix, where the
% third dimension is the method.
output_image = zeros(size(input_image,1),size(input_image,2),4);

% The first three methods are from that are mentioned in the blogpost:
% https://www.johndcook.com/blog/2009/08/24/algorithms-convert-color-grayscale/
% The fourth method is the method MATLAB uses for grayscale conversion.

% lightness method
% The lightness method scales an image to grayscale, by averaging the most
% prominent and the least prominent colors. So the max value of the three
% colors Red, Green, and Blue and the minimal values of the three
% colors Red, Green, and Blue. These two values are added together and
% divided by two.

% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Storing the RGB values.
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        % the grayscaling method:
        output_image(row,column,1) = (max([R,G,B]) + min([R,G,B]))/2;
    end
end

% average method
% The average method simply is the average of the RGB-colors, so (R+G+B)/3.

% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Storing the RGB values.
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        % the grayscaling method:
        output_image(row,column,2) = (R+G+B)/3;
    end
end

% luminosity method
% Instead of using the average method, the luminosity method uses the
% weighted average to calculate the correct grayscale. These values are
% weighted to account for the human perception. So 0.21*R+0.72*G+0.07*B,
% because humans are more sensitive to green it has a higher weighted
% average. 

% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Storing the RGB values.
        R = input_image(row, column, 1);
        G = input_image(row, column, 2);
        B = input_image(row, column, 3);
        % the grayscaling method:
        output_image(row,column,3) = 0.29*R+0.72*G + 0.07*B;
    end
end

% built-in MATLAB function for RGB color scheme to grayscale.
output_image(:,:,4) = rgb2gray(input_image);

% The goal is to examine which of the three functions is the same as the MATLAB
% function. By finding which grayscale image has the lowest difference in
% score, than that function is equal to the MATLAB builtin function, as
% they both score the pixels the same grayscale.
gray_1 = 0;
gray_2 = 0;
gray_3 = 0;
% Looping over all the rows of the image.
for row = 1:size(input_image, 1)
    % Looping over all the columns of the image.
    for column = 1:size(input_image, 2)
        % Summing the difference for the different techniques
        gray_1 = gray_1 + output_image(row,column,4) - output_image(row,column,1);
        gray_2 = gray_2 + output_image(row,column,4) - output_image(row,column,2);
        gray_3 = gray_3 + output_image(row,column,4) - output_image(row,column,3); 
    end
end

% Locating the correct method of grayscaling.
if gray_1 < min(gray_2, gray_3)
    disp('the MATLAB function = lightness method')
elseif gray_2 < min(gray_1, gray_3)
    disp('the MATLAB function = average method')
elseif gray_3 < min(gray_1, gray_2)
    disp('the MATLAB function = luminosity method')
end

% The builtin function is more equal to the average method in this example. 
% But is because of the difference in the weighting of the RGB colors. As
% matlab uses the 0.2989 * R + 0.5870 * G + 0.1140 * B as weights, and this
% scores the grayscale differently.

end


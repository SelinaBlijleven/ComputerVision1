function visualize(input_image)
%% The visualization of the images that have been transformed with the different functions.

% Examining the image of locate if the image is a colored image or not:

% Colored
if size(input_image,3) == 3
    figure
    imshow(input_image)
% Not Colored.
elseif size(input_image,3) == 4
    figure
    for image_number = 1:4
        subplot(2, 2, image_number);
        imshow(input_image(:,:,image_number))
    end
else
    disp('Not correct image loaded.')
end
function visualize(input_image)

if size(input_image,3) == 3
    figure
    imshow(input_image)
elseif size(input_image,3) == 4
    figure
    for image_number = 1:4
        subplot(2, 2, image_number);
        imshow(input_image(:,:,image_number))
    end
else
    disp('Not correct')
end
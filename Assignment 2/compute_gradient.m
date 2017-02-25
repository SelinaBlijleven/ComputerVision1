function [ im_magnitude , im_direction ] = compute_gradient ( image )
%% Gradient Magnitude
%

figure;
imshow(image);

kernel_size = 3;

x_conv = [ -1 0 1;
           -2 0 2;
           -1 0 1];
y_conv = x_conv';

image = padarray(image,1);
[xdim, ydim] = size(image);
imOut_X = zeros(xdim,ydim);

% X-direction
for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
    for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
        neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
        value_summed = 0;
        for elem_x=1:kernel_size
           for elem_y=1:kernel_size

               value_summed = value_summed + double(neighbors(elem_x, elem_y)).*x_conv(elem_x, elem_y);
           end
        end
        imOut_X(x,y) = value_summed;
    end
end

figure;

imshow(imOut_X, [min(min(imOut_X)),max(max(imOut_X))]);

imOut_Y = zeros(xdim,ydim);
% Y Direction
for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
    for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
        neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
        value_summed = 0;
        for elem_x=1:kernel_size
           for elem_y=1:kernel_size
               value_summed = value_summed + double(neighbors(elem_x, elem_y)).*y_conv(elem_x, elem_y);
           end
        end
        imOut_Y(x,y) = value_summed;
    end
end

figure;
imshow(imOut_Y, [min(min(imOut_Y)),max(max(imOut_Y))]);

im_magnitude = zeros(xdim,ydim);

for x=1:xdim %loop in x-dimension
    for y=1:ydim % loop in y-dimension
        magnitude = sqrt(imOut_X(x,y).^2+ imOut_Y(x,y).^2);
        im_magnitude(x,y) = magnitude;
    end
end

figure;
imshow(im_magnitude, [min(min(im_magnitude)),max(max(im_magnitude))]);



% Direction does not work correctly.
im_direction = zeros(xdim,ydim);

for x=1:xdim %loop in x-dimension
    for y=1:ydim % loop in y-dimension
        direction = atan(imOut_X(x,y)./ imOut_Y(x,y));
        im_direction(x,y) = direction;
    end
end

figure;
imshow(im_direction, [min(min(im_direction)),max(max(im_direction))]);

% Image Gradient direction


end
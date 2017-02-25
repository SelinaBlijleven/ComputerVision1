function imOut = gaussConv (image , sigma_x , sigma_y , kernel_size )
%% Conv


support = linspace(ceil(-kernel_size/2), floor(kernel_size/2), kernel_size);
[X,Y] = meshgrid(support,support);
G = exp( -(X.^2)/(2*sigma_x^2)+(Y.^2)/(2*sigma_y^2) );
Filter = G / sum(G(:));
disp(Filter)
[xdim, ydim] = size(image);
imOut = zeros(xdim, ydim);
image = padarray(image,floor(kernel_size/2));

for x=floor(kernel_size/2)+1:xdim-floor(kernel_size/2) %loop in x-dimension
    for y=floor(kernel_size/2)+1:ydim-floor(kernel_size/2) % loop in y-dimension
        neighbors = image(x-floor(kernel_size/2):x+floor(kernel_size/2),y-floor(kernel_size/2):y+floor(kernel_size/2));
        value_summed = 0;
        for elem_x=1:kernel_size
           for elem_y=1:kernel_size
               value_summed = value_summed + double(neighbors(elem_x, elem_y))*Filter(elem_x, elem_y);
           end
        end
        imOut(x,y) = round(value_summed);
    end
end


end
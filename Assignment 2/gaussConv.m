function imOut = gaussConv (image , sigma_x , sigma_y , kernel_size )

support = linspace(ceil(-kernel_size/2), floor(kernel_size/2), kernel_size);
[X,Y] = meshgrid(support,support);
G = exp( -(X.^2)/(2*sigma_x^2)+(Y.^2)/(2*sigma_y^2) );
G = G / sum(G(:));
imOut = conv2(image,G);
end
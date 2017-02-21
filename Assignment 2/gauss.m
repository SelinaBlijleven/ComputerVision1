function G = gauss(sigma ,kernel_size)
width = round(kernel_size/2);
support = (-width:width);
gaussFilter = exp( -(support).^2 ./ (2*sigma^2) );
gaussFilter = gaussFilter/ sum(gaussFilter);

end
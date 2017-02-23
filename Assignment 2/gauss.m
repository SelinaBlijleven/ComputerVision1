function G = gauss(sigma ,kernel_size)
support = linspace(ceil(-kernel_size/2), floor(kernel_size/2), kernel_size);
G = exp( -(support).^2 ./ (2*sigma^2) );
G = G/sum(G);

end
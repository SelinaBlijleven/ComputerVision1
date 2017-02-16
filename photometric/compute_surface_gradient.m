function [ albedo, normal, p, q ] = compute_surface_gradient( stack_images, scriptV )
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   stack_image : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   albedo : the surface albedo
%   normal : the surface normal
%   p : measured value of df / dx
%   q : measured value of df / dy

W = size(stack_images, 1);
H = size(stack_images, 2);
N = size(stack_images, 3);

% create arrays for 
%   albedo, normal (3 components)
%   p measured value of df/dx, and
%   q measured value of df/dy
albedo = zeros(W, H, 3);
normal = zeros(W, H, 3);
p = zeros(W, H);
q = zeros(W, H);

% for each point in the image array
for idx = 1:W
    for idy = 1:H
        
        %   stack image values into a vector of length N (for N images)
        %   construct the diagonal matrix scriptI
        i = zeros(N, 1);
        scriptI = zeros(N, N);
        
        for idn = 1:N
            i(idn) = stack_images(W, H, N);
            scriptI(idn, idn) = i(idn);
        end        

        %   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
        [g, R] = linsolve(scriptI * scriptV, scriptI * i);
        
        %   albedo at this point is |g|
        %   (same everywhere because we take the norm, not RGB)
        albedo(idx, idy) =  norm(g);

        %   normal at this point is g / |g|
        normal(idx, idy, :) = g / norm(g);
        
        %   p at this point is N1 / N3
        p(idx, idy) = normal(idx, idy, 1) / normal(idx, idy, 3);
        
        %   q at this point is N2 / N3
        q(idx, idy) = normal(idx, idy, 2) / normal(idx, idy, 3);
    end
end

end


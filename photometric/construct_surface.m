function [ height_map ] = construct_surface( p, q, W, H )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measured value of df / dx
%   q : measured value of df / dy
%   W : the width (counting the number of columns) of the height_map
%   H : the height (counting the number of rows) of the height_map
%   height_map: the reconstructed surface

height_map = zeros(W, H);

% Top left corner of the map stays zero.
% For every other point in the leftmost column:
% height_value = previous_height_value + corresponding_q_value
prev_height_val = height_map(1, 1);

for idy = 2:H
   height_map(1, idy) = prev_height_val + q(1, idy);
   prev_height_val = height_map(1, idy);
end

% For every point not in the left column:
% height_value = previous_height_value + corresponding_p_value
for idy = 1:H
    for idx = 2:W
        height_map(idx, idy) = prev_height_val + p(idx, idy);
    end
end
function [ height_map ] = construct_surface( p, q, W, H )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measured value of df / dx
%   q : measured value of df / dy
%   W : the width (counting the number of columns) of the height_map
%   H : the height (counting the number of rows) of the height_map
%   height_map: the reconstructed surface

height_map = zeros(W, H);

% top left corner of height_map is zero
% (and already initialized as such)

% for each pixel in the left column of height_map
%   height_value = previous_height_value + corresponding_q_value
prev_height_val = height_map(1, 1);

for idy = 2:numel(H)
   height_map(1, idx) = prev_height_val + q(1, idx);
   prev_height_val = height_map(1, idx)
end

% TODO: Your code goes here
% for each row
%   for each element of the row except for leftmost
%       height_value = previous_height_value + corresponding_p_value
for idy = 1:numel(H)
    for idx = 2:numel(W)
        height_map(idx, idy) = prev_height_val + p(idx, idy);
    end
end

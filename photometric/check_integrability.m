function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

dpdy = zeros(size(p, 1), size(p, 2));
dqdx = zeros(size(q, 1), size(q, 2));

% TODO: Your code goes here
% approximate derivate by neighbor difference

for num_row = 1:size(p, 1)-1
        for num_col = 1:size(p, 2)-1
                dpdy(num_row, num_col) = (p(num_row, num_col+1) - p(num_row, num_col))/(num_col+1 - num_col); 
        end;
end;

for num_col = 1:size(p, 2)-1
        for num_row = 1:size(p, 1)-1
                dqdx(num_row, num_col) = (q(num_row+1, num_col) - q(num_row, num_col))/(num_row+1 - num_row); 
        end;
end;


end


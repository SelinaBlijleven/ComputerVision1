function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

dpdy = zeros(size(p, 1), size(p, 2));
dqdx = zeros(size(q, 1), size(q, 2));

% approximate derivate by neighbor difference. The fastest way to calculate
% the integrability is to use the numerical values and calculate the
% difference between the two values. Our approximation takes into account
% that the first derivation is equal to zero.

% Loop through the rows first.
for num_row = 2:size(p, 1)
    % Through the columns second as the difference of the p-values with respect
    % to the Y-values are measured.
    for num_col = 2:size(p, 2)
        % difference = (P(x,y) + P(x,y-1))/(y-(y-1))
        dpdy(num_row, num_col) = (p(num_row, num_col) - p(num_row, num_col-1))/(num_col - num_col-1); 
    end;
end;

% Loop through the columns first.
for num_col = 2:size(p, 2)
    % Through the rows second as the difference of the q-values with respect
    % to the X-values are measured.
    for num_row = 2:size(p, 1)
        % difference = (Q(x,y) + Q(x-1,y))/(x-(x-1))
        dqdx(num_row, num_col) = (q(num_row, num_col) - q(num_row-1, num_col))/(num_row - num_row-1); 
    end;
end;


end


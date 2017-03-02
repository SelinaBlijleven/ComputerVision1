% Check for each point in H if bigger than neighbours in nxn
% neighbourhood, add points to r (row array) and c (column array).
function [r, c] = detect_corners(H, n)
    % H size
    [h, w] = size(H);

    % Initialize empty arrays
    r = [];
    c = [];
    
    % Normalize and pad H with zeros. By only looping through the actual
    % values later we eliminate the problem of boundary checking.
    normH = H - min(H(:));
    normH = normH ./ max(normH(:));
    paddedH = padarray(normH, [n n]);
    
    % Search corners
    for x = 1+n:w+n    % column after padding offset
        for y = 1+n:h+n    % row after padding offset
            biggest = true;
            for nbx = x - n:x + n    % neighbourhood column
                for nby = y - n:y + n    % neighbourhood row
                    if paddedH(nbx, nby) > paddedH(x, y)
                        biggest = false;
                    end
                end
            end
            if biggest == true  % If biggest value:
                c = [c, x];    % Append column
                r = [r, y];    % Append row
        end
    end      
end
function [r, c] = detect_corners(H, n)
    % Help function of harris_corner_detection.m
    % Checks for each point in H if bigger than neighbours in nxn
    % neighbourhood, add points to r (row array) and c (column array).
    
    % Input:
    % H: Cornerness matrix
    % n: Size of neighbourhood to compare cornerness with.
    
    % Output:
    % r: Row coordinates of detected corners
    % c: Column coordinates of detected corners
    
    % User defined threshold:
    threshold = 10000.0;

    % H size
    [h, w] = size(H);
    % Initialize empty arrays
    r = [];
    c = [];
    
    % Normalize and pad H with zeros. By only looping through the actual
    % values later we eliminate the problem of boundary checking.
    
    % normH = H - min(H(:));
    % normH = normH ./ max(normH(:));
    
    paddedH = padarray(H, [n n]);
    
    % Search corners
    for x = 1+n:h+n   % column after padding offset
        for y = 1+n:w+n   % row after padding offset
%             biggest = true;
%             for nbx = -n:n    % neighbourhood column
%                 for nby = -n:n    % neighbourhood row
%                     if paddedH(x+nbx, y+nby) > paddedH(x, y)
%                         biggest = false;
%                     end
%                 end
%             end
%             if biggest == true  % If biggest value:
            neighbors = paddedH(x-n:x+n,y-n:y+n);
            neighbors(n+1,n+1) = 0;
            if (paddedH(x,y) > max(max(neighbors))) && paddedH(x,y) > threshold
                c = [c, y];    % Append column
                r = [r, x];    % Append row
            end
        end
    end
end
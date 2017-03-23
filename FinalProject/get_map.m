function map = get_map(h, y)
    % Calculate Mean Average Precision
    % for a given set (class/all/whatever) of image classifications.
    % Both lists should be ranked such that the first result has the
    % highest certainty of being correct.
    
    % Input
    % h: Hypothesis classification
    % y: Actual classification
    
    % Get amount of images
    [x, n] = size(h);
    
    % Initialize sum
    ap = 0;
    
    % For each example
    for i=1:n
        % Compare classification
        if h(i) == y(i)
            % Add 1/rank to sum if correct
            ap = ap + 1/i;
        end
    end

    % Calculate mean
    map = (1/50) * ap;
    
end
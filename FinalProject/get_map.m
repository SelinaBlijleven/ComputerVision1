function map = get_map(h, y)
    % Calculate Mean Average Precision
    % for a given set (class/all/whatever) of image classifications.
    % Both lists should be ranked such that the first result has the
    % highest certainty of being correct.
    
    % Input
    % h: Hypothesis classification
    % y: Actual classification
    
    % Output
    % map: Mean average precision
    
    % Get amount of images
    [x, n] = size(h);
    
    % Initialize zero vector of prediction length
    correctness = zeros(x, n);
    
    % For each example
    for i=1:x
        % Set 1 for matching prediction actual values
        if h(i) == y(i)
            correctness(i, :) = 1;
        end
    end
    
    % Initialize sum
    ap = 0;
    % For each example
    for rank=1:x
        % Get amount of correct images in first i images
        correct = sum(correctness(1:rank, :));
        ap = ap + correct/rank;
    end
    
    % Calculate mean
    map = (1/200) * ap;
end
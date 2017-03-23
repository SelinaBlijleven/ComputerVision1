function [f, d] = feature_extraction(image, method)
    % Function that returns features and descriptors from an image
    % with the given method.
    
    % Input
    % Image: An image for feature extraction
    % Method: SIFT method from SIFT, denseSIFT, rgbSIFT, RGBSIFT, 
    %         opponentSIFT
    
    % Output
    % f: Features of image
    % d: Descriptors of image
    
    % Empty initialization
    f = [];
    d = [];

    % Regular SIFT with VLFeat
    if strcmp(method, 'SIFT')
        image = reduce_dimension(image);
        [f, d] = vl_sift(image);
    
    % Dense SIFT with VLFeat
    elseif strcmp(method, 'denseSIFT')
        image = reduce_dimension(image);
        [f, d] = vl_dsift(image);
    
    elseif strcmp(method, 'HSVSIFT')
        [f, d] = color_SIFT(image, 'HSV');
    
    elseif strcmp(method, 'RGBSIFT')
        [f, d] = color_SIFT(image, 'RGB');
    
    elseif strcmp(method, 'opponentSIFT')
        %
    end
end
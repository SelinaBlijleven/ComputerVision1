function imOut = myHistMatching (input , reference )
%% Histogram Matching
% takes input image and a reference image, and transforms the image in such
% a way that is has the same histogram as the reference image.

% Histogram image 1
[pixelCounts_1, grayLevels_1] = imhist(input);

%cumulative  histogram.
cumsum_image_1 = cumsum(pixelCounts_1);
bar(grayLevels_1, cumsum_image_1 , 'BarWidth', 1);


% Histogram image 2
[pixelCounts_2, grayLevels_2] = imhist(reference);

%cumulative  histogram.
cumsum_image_2 = cumsum(pixelCounts_2);
bar(grayLevels_2, cumsum_image_2 , 'BarWidth', 1);



end

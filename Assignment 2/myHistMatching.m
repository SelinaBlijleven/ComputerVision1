function imOut = myHistMatching (input , reference )
%% Histogram Matching
% takes input image and a reference image, and transforms the image in such
% a way that is has the same histogram as the reference image.

% Histogram image 1
[pixelCounts_1, grayLevels_1] = imhist(input);
% CDF image 1 histogram.
cdf_im_1 = cumsum(pixelCounts_1)/sum(pixelCounts_1);
figure;
imshow(input, [1,256]);
hold on
plot(grayLevels_1, cdf_im_1 , 'LineWidth', 1);
hold off
% Histogram image 2
[pixelCounts_2, grayLevels_2] = imhist(reference);

% CDF image 2 histogram.
cdf_im_2 = cumsum(pixelCounts_2)/sum(pixelCounts_2);
figure;
imshow(reference, [1,256]);
hold on
plot(grayLevels_2, cdf_im_2 , 'LineWidth', 1);
hold off

% Build the lookup table
lookup = zeros(size(cdf_im_1,1),1);
for i = 1:size(cdf_im_1,1)
    min_score = 1;
    for j = 1:size(cdf_im_2,1)
        new_score = abs(cdf_im_1(i) - cdf_im_2(j));
        if new_score < min_score
            min_score = new_score;
            lookup(i) = j;
        end
    end
end

%transform image

imOut = zeros(size(input));
for i = 1:size(input,1) 
    for j = 1:size(input,2)
        imOut(i,j) = lookup(input(i,j));
    end
end

lookup = zeros(256,1);
for i = 1:size(input,1) 
    for j = 1:size(input,2)
        lookup(imOut(i,j)) = lookup(imOut(i,j)) + 1;
    end
end
cdf_im_3 = cumsum(lookup)/sum(lookup);

figure;
imshow(imOut, [1,256]);
hold on
plot(grayLevels_1, cdf_im_3 , 'LineWidth', 1);
hold off



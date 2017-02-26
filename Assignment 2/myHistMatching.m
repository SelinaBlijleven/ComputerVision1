function imOut = myHistMatching (input , reference )
%% Histogram Matching
% takes input image and a reference image, and transforms the image in such
% a way that is has the same histogram as the reference image.
% Input:
% input = the image that has to be transformed to the histogram of the reference.
% Reference = the reference image that is used to transform the input image.

% Histogram image 1
[pixelCounts_1, grayLevels_1] = imhist(input);

% CDF image 1 histogram.
cdf_im_1 = cumsum(pixelCounts_1)/sum(pixelCounts_1);

% Plotting of the input image and histogram.
figure;
subplot(2,1,1), imshow(input, [1,256]);
subplot(2,1,2), plot(grayLevels_1, cdf_im_1 , 'LineWidth', 1);

% Histogram image 2
[pixelCounts_2, grayLevels_2] = imhist(reference);

% CDF image 2 histogram.
cdf_im_2 = cumsum(pixelCounts_2)/sum(pixelCounts_2);

% Plotting of the reference image and histogram.
figure;
subplot(2,1,1), imshow(reference, [1,256]);
subplot(2,1,2),plot(grayLevels_2, cdf_im_2 , 'LineWidth', 1);

% Preallocation of the lookup table
lookup = zeros(size(cdf_im_1,1),1);

% Building the lookup table, in which the correct pixel values are stored. 
for i = 1:size(cdf_im_1,1) % Looping over the values of CDF 1
    min_score = 1; % starting value to find the best pixelcolor that minimizes the difference between the two histograms.
    for j = 1:size(cdf_im_2,1) % Looping over the values of CDF 2
        new_score = abs(cdf_im_1(i) - cdf_im_2(j)); % Calculation of the new minimum score.
        if new_score < min_score
            min_score = new_score;
            % When smaller than the smallest score until now, store the new
            % pixelvalue.
            lookup(i) = j;
        end
    end
end

% Transform image by using the lookup table to find te correct color of
% every pixel that the image has.
imOut = zeros(size(input));
for i = 1:size(input,1) % Looping over the x-values
    for j = 1:size(input,2) % Looping over the y-values
        imOut(i,j) = lookup(input(i,j));
    end
end

% Calculation of the histogram of the transformed image. 
Histogram_transform_image = zeros(256,1);
for i = 1:size(input,1) 
    for j = 1:size(input,2)
        Histogram_transform_image(imOut(i,j)) = Histogram_transform_image(imOut(i,j)) + 1;
    end
end

% the calculation of the CDF of the transformed image.
cdf_im_3 = cumsum(Histogram_transform_image)/sum(Histogram_transform_image);

% Plotting of the reference image and histogram.
figure;
subplot(2,1,1), imshow(imOut, [1,256]);
subplot(2,1,2),plot(grayLevels_2, cdf_im_3 , 'LineWidth', 1);



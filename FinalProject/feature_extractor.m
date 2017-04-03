function feature_matrix = feature_extractor(imd_kmeans_vocab, feature_method)

if strcmp(feature_method,'denseSIFT')
    feature_matrix = single(zeros(128,length(imd_kmeans_vocab.Labels)*20000));
else
    img = readimage(imd_kmeans_vocab,1);
    img = im2single(img);
    d = feature_extraction(img, feature_method);
    [feature_size, ~] = size(single(d));
    feature_matrix = single(zeros(feature_size,length(imd_kmeans_vocab.Labels)*1800));
end


disp('Start the Feature extraction of the top set of images')
loc_elem = 1;

for i = 1:length(imd_kmeans_vocab.Labels)
    imd_kmeans_vocab.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_kmeans_vocab,i);
    % Extract the SIFT features to create a K_means matrix needed to find
    % the centres fot the vocal words.
    img = im2single(img);
    
    % Check if RGB or grayscale
    if numel(size(img))>=3 || not(strncmp(fliplr(feature_method),fliplr('SIFT'),4))
        % If image is RGB perform given SIFT type.
        d = feature_extraction(img, feature_method);
    else
        % If image is grayscale default to standard SIFT.
        disp('Grayscale image found. ColorSIFT is not supported.')
        disp('Now using standard SIFT.')
        d = feature_extraction(img, 'SIFT');
    end
    [~, length_dense_size] = size(single(d));
    loc_elem_new = loc_elem + length_dense_size;
    feature_matrix(:,loc_elem:loc_elem_new-1) = single(d);
    loc_elem = loc_elem_new;
end
feature_matrix(:, loc_elem_new:end) = [];
end
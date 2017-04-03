function [data, label_air, label_car, label_face, label_bike] = feature_quantizer(imd_train, vocab_size, feature_method, C)

data = double(zeros(length(imd_train.Labels),vocab_size));
label_air = zeros(length(imd_train.Labels),1);
label_car = zeros(length(imd_train.Labels),1);
label_face = zeros(length(imd_train.Labels),1);
label_bike = zeros(length(imd_train.Labels),1);

% Setting the bin_size
x = linspace(1,vocab_size,vocab_size);

for i = 1:length(imd_train.Labels)
    label = imd_train.Labels(i); % Gives the label of the image that is read
    img = readimage(imd_train,i);
    img = im2single(img);
    if numel(size(img))>=3 || not(strncmp(fliplr(feature_method),fliplr('SIFT'),4))
        d = feature_extraction(img, feature_method);
    else
        d = feature_extraction(img, 'SIFT');
    end
    k = dsearchn(C,single(d)');
    
    % Step 4: Representing images by frequencies
    hist_im = hist(k,x);
    hist_im = double(hist_im ./ max(hist_im));
    data(i,:) = hist_im;    
    if label == 'airplanes_train'
        label_air(i) = 1;
    elseif label == 'cars_train'
        label_car(i) = 1;
    elseif label == 'faces_train'
        label_face(i) = 1;
    elseif label == 'motorbikes_train'
        label_bike(i) = 1;
    end
end
end
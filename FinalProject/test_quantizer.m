function [data_test, test_air, test_car, test_face, test_bike, file_loc] = test_quantizer(imd_test, vocab_size, feature_method, C)

data_test = double(zeros(length(imd_test.Labels),vocab_size));
test_air = zeros(length(imd_test.Labels),1);
test_car = zeros(length(imd_test.Labels),1);
test_face = zeros(length(imd_test.Labels),1);
test_bike = zeros(length(imd_test.Labels),1);
file_loc = strings(length(imd_test.Labels),1);

% Setting the bin_size
x = linspace(1,vocab_size,vocab_size);

for i = 1:length(imd_test.Labels)
    label = imd_test.Labels(i); % Gives the label of the image that is read
    [img,fileinfo] = readimage(imd_test,i);
    file_loc(i) = strrep(fileinfo.Filename,path_to_loc,'');
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
    data_test(i,:) = hist_im;    
    if label == 'airplanes_test'
        test_air(i) = 1;
    elseif label == 'cars_test'
        test_car(i) = 1;
    elseif label == 'faces_test'
        test_face(i) = 1;
    elseif label == 'motorbikes_test'
        test_bike(i) = 1;
    end
end
end
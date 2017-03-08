function track_corners(map)
%% Tracking corners of a set of images and save a video of the set of images.
% Input: takes the map of the set of images

% Checks which map is used, as both maps have different image extensions
if ~isempty(strfind(map, 'person_toy'))
    % open files
    files = dir(strcat(map,'*.jpg'));
    files = files(2:end);
    % store the first image in the correct variable.
    image_1 = rgb2gray(imread('person_toy/00000001.jpg'));
elseif ~isempty(strfind(map, 'pingpong'))
    % open files
    files = dir(strcat(map,'*.jpeg'));
    files = files(2:end);
    % store the first image in the correct variable.
    image_1 = rgb2gray(imread('pingpong/0000.jpeg'));
else
   'Not the correct file name'
end
% Creation of the output map.
out_map = strcat('out_',map);
[H, r, c] = harris_corner_detection(image_1);

for file = files'
    % Using the lucas kanade algorithm to calculate the velocity and the
    % new corners.
    image_2 = rgb2gray(imread(strcat(map,file.name)));
    [r, c] = lucas_kanade_algorithm(image_1, image_2, r, c, strcat(out_map,file.name));
    image_1 = image_2;
end

% Open the correct files of the image where the to process images are
% stored. With the check to make sure the extension is correct.
if ~isempty(strfind(out_map, 'out_person_toy'))
    % Use video writer to build the video.
    outputVideo = VideoWriter(fullfile(out_map,'out_person_toy.avi'));
    open(outputVideo);
    % Loop through the images that can be transferred into a video.
    for file = dir(strcat(out_map,'*.jpg'))'
        img = imread(strcat(out_map,file.name));
        writeVideo(outputVideo,img);
    end
    close(outputVideo);
elseif ~isempty(strfind(out_map, 'out_pingpong'))
    outputVideo = VideoWriter(fullfile(out_map,'out_pingpong.avi'));
    open(outputVideo);
    for file = dir(strcat(out_map,'*.jpeg'))'
        img = imread(strcat(out_map,file.name));
        writeVideo(outputVideo,img);
    end
    close(outputVideo);
end

end
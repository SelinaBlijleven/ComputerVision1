function track_corners(map)
if ~isempty(strfind(map, 'person_toy'))
    files = dir(strcat(map,'*.jpg'));
    files = files(2:end);
    image_1 = rgb2gray(imread('person_toy/00000001.jpg'));
elseif ~isempty(strfind(map, 'pingpong'))
    files = dir(strcat(map,'*.jpeg'));
    files = files(2:end);
    image_1 = rgb2gray(imread('pingpong/0000.jpeg'));
else
   'Not the correct file name'
end
out_map = strcat('out_',map);
[H, r, c] = harris_corner_detection(image_1);
for file = files'
    image_2 = rgb2gray(imread(strcat(map,file.name)));
    [r, c] = lucas_kanade_algorithm(image_1, image_2, r, c, strcat(out_map,file.name));
    image_1 = image_2;
end
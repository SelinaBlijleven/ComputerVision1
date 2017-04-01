fileID = fopen('html_images.txt','w');

for i = 1:length(bike)
    cc_string = '<tr><td><img src="';
    add_string = '" /></td><td><img src="';
    final_string = '" /></td></tr>';
    [air_str_end, ~] = strsplit(strrep(air(i,2),'\','/'),'FinalProject/');
    [car_str_end, ~] = strsplit(strrep(car(i,2),'\','/'),'FinalProject/');
    [face_str_end, ~] = strsplit(strrep(face(i,2),'\','/'),'FinalProject/');
    [bike_str_end, ~] = strsplit(strrep(bike(i,2),'\','/'),'FinalProject/');
    compl_string = strcat(cc_string,air_str_end(2),add_string,car_str_end(2),add_string,face_str_end(2),add_string,bike_str_end(2),final_string);
    fprintf(fileID,compl_string);
end
fclose(fileID);
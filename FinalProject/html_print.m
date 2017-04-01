function html_print(air, car, face, bike, sift_step_size, sift_block_size, sift_type, vocab_size, vocab_fraq, positive, negative, kernel_type)
fileID_1 = fopen(strcat('html_images_',num2str(vocab_size),'_',sift_type,'.html'),'w');
fileID_2 = fopen('Template_Result.html','r');


ap_air = get_map(double(air(:,4)),double(air(:,3)));
ap_car = get_map(double(car(:,4)),double(car(:,3)));
ap_face = get_map(double(face(:,4)),double(face(:,3)));
ap_bike = get_map(double(bike(:,4)),double(bike(:,3)));

map = mean([ap_air, ap_car, ap_face, ap_bike]);

tline = fgetl(fileID_2);
while ischar(tline)
    tline = fgetl(fileID_2);
    
    if strcmp(tline,'image_get')
        for i = 1:length(bike)
            cc_string = '<tr><td><img src="';
            add_string = '" /></td><td><img src="';
            final_string = '" /></td></tr>';
            air_str_end = strcat('data/Caltech4/ImageData/',strrep(air(i,2),'\','/'));
            car_str_end = strcat('data/Caltech4/ImageData/',strrep(car(i,2),'\','/'));
            face_str_end = strcat('data/Caltech4/ImageData/',strrep(face(i,2),'\','/'));
            bike_str_end = strcat('data/Caltech4/ImageData/',strrep(bike(i,2),'\','/'));
            compl_string = strcat(cc_string,air_str_end,add_string,car_str_end,add_string,face_str_end,add_string,bike_str_end,final_string);
            fprintf(fileID_1,compl_string);
        end
    elseif strcmp(tline,'<h2>stu1_name, stu2_name</h2>')
        fprintf(fileID_1,'<h2>Selina Blijleven, Thomas de Groot</h2>');
        
    elseif strcmp(tline,'<tr><th>SIFT step size</th><td>XXX px</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SIFT step size</th><td>',num2str(sift_step_size), ' px</td></tr>'));
        
    elseif strcmp(tline,'<tr><th>SIFT block sizes</th><td>XXX pixels</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SIFT block sizes</th><td>',num2str(sift_block_size), ' pixels</td></tr>'));
        
    elseif strcmp(tline,'<tr><th>SIFT method</th><td>XXX-SIFT</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SIFT method</th><td>',sift_type, '-SIFT</td></tr>'));
        
    elseif strcmp(tline,'<tr><th>Vocabulary size</th><td>XXX words</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SIFT method</th><td>',num2str(vocab_size), ' words</td></tr>')); 
        
    elseif strcmp(tline,'<tr><th>Vocabulary fraction</th><td>XXX</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>Vocabulary fraction</th><td>',num2str(vocab_fraq), '</td></tr>'));
        
    elseif strcmp(tline,'<tr><th>SVM training data</th><td>XXX positive, XXX negative per class</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SVM training data</th><td>',num2str(positive), ' positive, ',num2str(negative), ' negative per class</td></tr>'));
        
    elseif strcmp(tline,'<tr><th>SVM kernel type</th><td>XXX</td></tr>')
        fprintf(fileID_1,strcat('<tr><th>SVM kernel type</th><td>',kernel_type, '</td></tr>'));
        
    elseif strcmp(tline,'<h1>Prediction lists (MAP: 0.XXX)</h1>')
        fprintf(fileID_1,strcat('<h1>Prediction lists (MAP: ',num2str(map),' )</h1>'));
        
    elseif strcmp(tline,'<th>Airplanes (AP: 0.XXX)</th><th>Cars (AP: 0.XXX)</th><th>Faces (AP: 0.XXX)</th><th>Motorbikes (AP: 0.XXX)</th>')
        fprintf(fileID_1,strcat('<th>Airplanes (AP: ',num2str(ap_air),' )</th><th>Cars (AP: ',num2str(ap_car),')</th><th>Faces (AP: ',num2str(ap_face),')</th><th>Motorbikes (AP: ',num2str(ap_bike),')</th>'));
        
    else
        fprintf(fileID_1,char(tline));
    end
    fprintf(fileID_1,'\n');
end
fclose(fileID_1);
fclose(fileID_2);
end
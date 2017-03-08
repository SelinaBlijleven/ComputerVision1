function main()
    %%%%%%%%%%%%%%%%%%
    % Initialization %
    %%%%%%%%%%%%%%%%%%
    
    % Make plots not visible
    set(0,'DefaultFigureVisible', 'off');
    
    
    toy_image = rgb2gray(imread('person_toy/00000001.jpg'));
    pingpong_image = rgb2gray(imread('pingpong/0000.jpeg'));
    
    sphere1 = imread('sphere1.ppm');
    sphere2 = imread('sphere2.ppm');
    synth1 = imread('synth1.pgm');
    synth2 = imread('synth2.pgm');
    
    %%%%%%%%%%%%%
    % Section 1 %
    %%%%%%%%%%%%%
    
    % A demo function should return the H matrix, the rows of the detected 
    % corner points r, and the columns of those points c - so the ?rst 
    % corner is given by (r(1), c(1)). 
    %[H, r, c] = harris_corner_detection(image);
    
    % Produces the images for person toy/00000001.jpg and 
    % pingpong/0000.jpeg that were required for the report.
    
%     [H, r, c] = harris_corner_detection(toy_image);
%     [H, r, c] = harris_corner_detection(pingpong_image);
    
    %%%%%%%%%%%%%
    % Section 2 %
    %%%%%%%%%%%%%
    
    %%%%%%%%%%%%%
    % Section 3 %
    %%%%%%%%%%%%%
    
    % A demo function which runs the whole routine with all other 
    % functions you have implemented. 
    
    % Visualizations of two optical ?ows for sphere and synth images 
    % should be submitted.
        
    lucas_kanade_algorithm(sphere1, sphere2);
    lucas_kanade_algorithm(synth1, synth2);
    
    %%%%%%%%%%%%%
    % Section 4 %
    %%%%%%%%%%%%%
    
    % Demo functions which run the trackers (Harris Corner Detector and 
    % the combination with Lucas-Kanade algorithm) with all other 
    % supporting functions you have implemented. 
    
    % Visualization videos of two implemented trackers for pingpong and 
    % person toy should be submitted.
    
    track_corners('person_toy/');
    track_corners('pingpong/');

end
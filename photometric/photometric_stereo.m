% obtain many images in a fixed view under different illumination
[image_stack, W, H] = load_image();

% determine the matrix scriptV from source and camera information
scriptV = get_source(200);

[albedo, normal, p, q] = compute_surface_gradient(image_stack, scriptV);

p(isnan(p)) = 0;
q(isnan(q)) = 0;

% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
[dpdy, dqdx] = check_integrability(p, q);

% compute the surface height
height_map = construct_surface( p, q, W, H );

% plot the results
figure(1) 

% The first plot shows the Integrability check. This checks if the function
% that is plotted is continuous. As seen in the plot, it is clearly visible
% that the function is for the most part continuous, but the edge of the
% circle shows the radius of the sphere, as the back of the sphere isn't
% modeled this part can't be detected. With the expection of these points
% the sphere can be modeled correcly.
subplot(2, 2, 1);
[X, Y] = meshgrid(1:512, 1:512);
sqdiff = (dpdy - dqdx).^2;
surf(X, Y, sqdiff, gradient(sqdiff));
title('Integrability check: (dp / dy - dq / dx) ^2 ');
axis([0,512,0,512,0, 1000]);

% The second plot shows the reflectance of the surface of the input images.
% This image is used to check if V, the properties of the illumination and of the
% are correcly modeled. In the image it possible to see that the source
% vector is correctly modeled, as the complete image has the has the
% pixelvalues ranging from zero to one.
subplot(2, 2, 2);
imshow(albedo);
title('Albedo');

% As the partial derivatives, mostly, have passed the Integrability check
% the surface can be reconstructed with the help of a meshgrid. By using
% the derivatives the we can use the change in the surface height to create
% a surface map that shows the height field that is obtained with the
% normal field. This is shown in plot 3.
subplot(2, 2, 3);
[X_sub, Y_sub] = meshgrid(1:32:512, 1:32:512);  
surf(X_sub, Y_sub, height_map(1:32:end, 1:32:end));
xlabel('x'),ylabel('y'),zlabel('z');
title('Surface Mesh');
axis([0,512,0,512,0, 400]);

% The final plot shows the normal field that has been recovered from the
% images that have been inputted in the function. The normals show the way
% the light is reflected of the object if the light source is directly on
% top of the surfacepatch.
[U, V, W] = surfnorm(X_sub, Y_sub, height_map(1:32:end, 1:32:end));
subplot(2, 2, 4), 
quiver3(X_sub, Y_sub, height_map(1:32:end, 1:32:end), U, V, W, 0.5);
xlabel('x'),ylabel('y'),zlabel('z');
title('Surface normals');
axis([0,512,0,512,0, 400]);
    

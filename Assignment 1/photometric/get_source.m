function [ scriptV ] = get_source(scale_factor)
%GET_SOURCE compute illumination source property 
%   scale_factor : arbitrary 

if nargin == 0
    scale_factor = 1;
end

% define arbitrary direction to V
% k is the constant connecting the camera response to the input radiance.
% So here the value is 1.
k = 1;
scriptV = zeros(5,3);
% The five image directions.
% These are hardcoded as that was the easiest way to implement the
% directions without using the images that were available calculating the
% directions.
S = [0,0,-1;
    1,1,-1;
    1,-1,-1;
    -1,1,-1;
    -1,-1,-1];

% normalize V into scriptV
for i=1:5
    scriptV(i,:) = k*(S(i,:)/norm(S(i,:)));
end

% scale up to scale factor before return
scriptV = scale_factor * scriptV;

end


function [ scriptV ] = get_source(scale_factor)
%GET_SOURCE compute illumination source property 
%   scale_factor : arbitrary 

if nargin == 0
    scale_factor = 1;
end


% TODO: define arbitrary direction to V
% k is the constant connecting the camera response to the input randiance.
% So here the value is 1.
k = 1;
V = zeros(5,3);
% The five image directions.
S = [256,256,-1;
    1,512,-1;
    512,1,-1;
    1,1,-1;
    1,512,-1];
for i=1:5
    V(i,:) = k*S(i,:);
end

% TODO: normalize V into scriptV
scriptV = zeros(5,3);

% for i=1:5
%     normal_vec = Normalization_standard*V(i,:).';
%     scriptV(i,:) = normal_vec([1,2])*normal_vec(3);
% end
scriptV = V;

% scale up to scale factor before return
scriptV = scale_factor * scriptV;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to convert world coordinates
% to image coordinates
% by Anirudh Vemula, Aug 8, 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

H = dlmread('H.txt');

data = dlmread('obsmat.txt');

% pos = [xpos ypos 1]
pos = [data(:,3) data(:,5) ones(size(data,1),1)];

% Assuming H converts world coordinates to image coordinates
pixel_pos_unnormalized = pinv(H) * pos';

% Normalize pixel pos
% Each column contains [u; v] 
pixel_pos_normalized = bsxfun(@rdivide, pixel_pos_unnormalized([1,2],:), ...
                              pixel_pos_unnormalized(3,:));


% Add frame number and pedestrian ID information to the matrix
pixel_pos_frame_ped = [data(:,1)'; data(:,2)';pixel_pos_normalized];


pixel_pos_frame_ped(3,:) = pixel_pos_frame_ped(3,:) / 576;
pixel_pos_frame_ped(4,:) = pixel_pos_frame_ped(4,:) / 720;

% Save the positions to a mat file
save('pixel_pos.mat', 'pixel_pos_frame_ped');
csvwrite('pixel_pos.csv', pixel_pos_frame_ped);

% Extract pedestrian data
%x = {};
%y = {};
%t = {};
%frameid = {};

%fps = 25;

%uniquelocs = unique(pixel_pos_frame_ped(2,:));

%for i=1:size(uniquelocs,2)
%    x{uniquelocs(i)} = pixel_pos_frame_ped(4,pixel_pos_frame_ped(2,:)== ...
%                               uniquelocs(i));
%    y{uniquelocs(i)} = pixel_pos_frame_ped(3,pixel_pos_frame_ped(2,:)== ...
%                               uniquelocs(i));
%    framenums = pixel_pos_frame_ped(1, pixel_pos_frame_ped(2,:)== ...
%                                    uniquelocs(i));
    
%    dt = diff(framenums)/fps;
    
    %if isempty(dt)
    %    t{uniquelocs(i)} = [dt dt(end)];
    %end
    
    %    frameid{uniquelocs(i)} = framenums;
    %end

% Save pedestrian data to a mat file
%save('ped_data.mat', 'x','y', 't', 'frameid');

% Information about what pedestrians are in a specific frame and
% their locations

%uniqueframes = unique(pixel_pos_frame_ped(1,:));

%frameToPed = {};

%for i=1:size(uniqueframes, 2)
    
%    frameToPed{uniqueframes(i)} = pixel_pos_frame_ped(2, ...
%                                                      pixel_pos_frame_ped(1,:) == uniqueframes(i));
    
%end

% Save frameToPed data
%save('frame_to_ped.mat', 'frameToPed');

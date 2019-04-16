function img = drawBox(img, rect, rgb, thickness)
% drawBox draws a box on the input image
% 
% arguments:
% rect:         [x, y, width, height] //w, y, width, height all in integer
% rgb:          [r g b] //r, g, b are numbers between 0 and 255
% thinkness:    a scalar to specify the thickness of the box 
%               *thinkness has to be an odd number*
%
% usage:
% img = imread('onion.png');
% rect = [65, 45, 30, 30];
% rgb = [255, 0 , 0];
% thickness = 3;
% img = drawBox(img, rect, rgb, thickness);

%-----------------
% parameters
%-----------------
rect = floor(rect); % indices have to be of the integer type
x = rect(1); y = rect(2); w = rect(3); h = rect(4);
[img_h, img_w, dummy] = size(img);

% coordinate system
% 
% -------x----------
% |
% |
% y
% |
% |

%-----------------
% error checking
%-----------------

if mod(thickness-1, 2) ~= 0
    error('thickness has to be an odd number.');
end
thickness = (thickness-1)/2;

% fill the outter box
% boundary condition check
%y-t:y+h-1+t, x-t:x+w-1+t
oy_start = max(1, y-thickness); oy_end = min(img_h, y+h-1+thickness);
ox_start = max(1, x-thickness); ox_end = min(img_w, x+w-1+thickness);
outter_patch = img(oy_start:oy_end, ox_start:ox_end, :);

% put the inner box back
%y+t+1:y+h-t-2, x+t+1:x+w-t-2
iy_start = max(1, y+thickness+1); iy_end = min(img_h, y+h-thickness-2);
ix_start = max(1, x+thickness+1); ix_end = min(img_w, x+w-thickness-2);
inner_patch = img(iy_start:iy_end, ix_start:ix_end, :);


% the type of the outter box has to match the type of the image

oh = size(outter_patch, 1); ow = size(outter_patch, 2);
outter_box = cat(3, ones(oh, ow, 1) * rgb(1),...
                                    ones(oh, ow, 1, 1) * rgb(2),...
                                    ones(oh, ow, 1, 1) * rgb(3)); 
switch class(img)
    case 'double'
        outter_box = im2double(outter_box);
    case 'uint8'
        % do nothing
    otherwise
        error(['Unsppported image type: ' class(img)]);
end

img(oy_start:oy_end, ox_start:ox_end, :) = outter_box;
img(iy_start:iy_end, ix_start:ix_end, :) = inner_patch;

% -------------------------------------------------------------------------
% Part 3 - Create a I <3 NY image
% -------------------------------------------------------------------------

% Load the image "I_Love_New_York.png" into memory
iheartny_img = imread('I_Love_New_York.png');

% Display the image
figure, imshow(iheartny_img);

% Convert the color image into a grayscale image
gray_iheartny_img = rgb2gray(iheartny_img);

% Display the image
figure, imshow(gray_iheartny_img);

% Convert the grayscale image into a binary mask using a threshold value
threshold = .9;

binary_mask = im2bw(gray_iheartny_img, threshold);

% Load the image "nyc.png" into memory
nyc_img = imread('nyc.png');

% Resize nyc_img so the image height is 500 pixels
height = size(nyc_img, 1);

scale = 500/height;
small_nyc = imresize(nyc_img, scale);

% Resize ILoveNY binary_mask so that its height is 400 pixels
scale = 400 / size(binary_mask, 1);
resized_mask = imresize(binary_mask, scale);

imshow(resized_mask);

% Invert the mask
iresized_mask = ~resized_mask; imshow(iresized_mask);

% Note small_nyc and iresized_mask are of different height and width
size(small_nyc)
size(iresized_mask)

% No worries. Let's used the collage technique learned in Part 2 to make 
% iresized_mask with the same height and width as small_nyc
height_diff = size(small_nyc, 1) - size(iresized_mask, 1);
width_diff = size(small_nyc, 2) - size(iresized_mask, 2);
mask_height = size(iresized_mask, 1); mask_width = size(iresized_mask, 2);
imshow(iresized_mask); 

% Pad left and right
iresized_mask = [zeros(mask_height, width_diff/2),...
    iresized_mask, zeros(mask_height, width_diff/2)];
imshow(iresized_mask); 

% Pad top and bottom
mask_width = size(iresized_mask, 2);
iresized_mask = [zeros(height_diff / 2, mask_width); iresized_mask;...
    zeros(height_diff / 2, mask_width)];
% Cast the mask to logical
iresized_mask = logical(iresized_mask);
imshow(iresized_mask);


% MATLAB has many conveninent functions. The above code can actually be done
% with single line of MATLAB code. 
% The MATLAB documentation is a good place to discover what tools are
% available to you!

% ipadded_mask = padarray(iresized_mask, [height_diff/2 width_diff/2]);

% Now, let's burn the I <3 NY logo into the Manhattan scene
red = [255, 0, 0];
love_small_nyc = small_nyc;

red_channel = love_small_nyc(:, :, 1);
red_channel(iresized_mask) = red(1);
love_small_nyc(:, :, 1) = red_channel;

green = [0, 0, 0];
green_channel = love_small_nyc(:, :, 2);
green_channel(iresized_mask) = green(2);
love_small_nyc(:, :, 2) = green_channel;

blue = [0, 0, 0];
blue_channel = love_small_nyc(:, :, 3);
blue_channel(iresized_mask) = blue(3);
love_small_nyc(:, :, 3) = blue_channel;

figure, imshow(love_small_nyc);

% Save the collage as output_nyc.png
imwrite(love_small_nyc, 'output_nyc.png');

%--------------------------------------------------------------------------
% Walkthrough 1
%--------------------------------------------------------------------------

%----------------- 
% Convert a grayscale image to a binary image
%-----------------
fh1 = figure;
img = imread('coins.png');
subplot(1, 2, 1);
imshow(img); title('Original Image');

% Convert the image into a binary image by applying a threshold
%threshold = ??;

bw_img = im2bw(img, threshold);
subplot(1, 2, 2);
imshow(bw_img); title('Binary Image');

saveas(fh1, 'binary_coins.png');

%----------------- 
% Remove noises in the binary image
%-----------------
% Clean the image (you may notice some holes in the coins) by using
% dilation and then erosion
fh2 = figure;

% Specify the number of dilations/erosions
%k = ??;

processed_img = bwmorph(bw_img, 'dilate', k);
subplot(1, 2, 1);
imshow(processed_img); title('After Dilation');

% Apply erosion then dilation once to remove the noises
processed_img = bwmorph(processed_img, 'erode', k);
subplot(1, 2, 2);
imshow(processed_img); title('After Erosion');

saveas(fh2, 'noise_removal_coins.png');

%----------------- 
% Remove the rices
%-----------------
% Apply erosion then dilation once to remove the rices
fh3 = figure;

% Specify the number of erosions/dilations
%k = ??;

processed_img = bwmorph(processed_img, 'erode', k);
subplot(1, 2, 1);
imshow(processed_img); title('After Erosion');

processed_img = bwmorph(processed_img, 'dilate', k);
subplot(1, 2, 2);
imshow(processed_img); title('After Dilation');

saveas(fh3, 'morphological_operations_coins.png');

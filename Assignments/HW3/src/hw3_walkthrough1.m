%--------------------------------------------------------------------------
% Walkthrough 1
%--------------------------------------------------------------------------

%----------------------- 
% Image processing: convolution, Gaussian smoothing
%-----------------------
% Image credit: http://commons.wikimedia.org/wiki/File:Beautiful-pink-flower_-_West_Virginia_-_ForestWander.jpg

img = imread('flower.png');
fh = figure; subplot(2, 2, 1); imshow(img); title('Original');

% Here we will demonstrate apply Gaussian blur with three different sigmas.
% Initialize the sigma list
sigma = [6, 12, 24];

% Rule of thumb: set kernal size k ~= 2*pi*sigma
k = ceil(2*pi*sigma);

% In the following loop, each iteration applies a Gaussian blur with a
% different sigma
for i = 1:length(k)

    % Generate a Gaussian kernal 
    h = fspecial('gaussian', [k(i) k(i)], sigma(i));
    
    % Perform convolution 
    blur_img = imfilter(img, h, 'conv', 'replicate');
    
    % Display the result
    subplot(2, 2, i+1); imshow(blur_img); title(['\sigma = ' num2str(sigma(i))]);
end

saveas(fh, 'blur_flowers.png');

%----------------------- 
% Edge detection
%-----------------------
% Image credit: CAVE Lab

img = imread('hello.png');
fh = figure;
subplot(2, 2, 1); imshow(img); title('Color Image');

% Convert the image to grayscale
gray_img = rgb2gray(img); 
subplot(2, 2, 2); imshow(gray_img); title('Grayscale Image');


% Sobel edge detection
thresh = 0.1055;

edge_img = edge(gray_img, 'sobel', thresh);
subplot(2, 2, 3); imshow(edge_img); title('Sobel Edge Detection');

% Canny edge detection
thresh = 0.18;

edge_img = edge(gray_img,'canny', thresh);
subplot(2, 2, 4); imshow(edge_img); title('Canny Edge Detection');

saveas(fh, 'hello_edges.png');

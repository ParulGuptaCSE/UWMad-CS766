function demoMATLABTricksFun()
% This demo shows you the following tricks:
% - how to 'color' a labeled image to make the labeled image easier to see,
% - how to use plot and line to annotate an image,
% - how to save an annotated image.
%
% When you use plot or line to annotate a displayed image, the
% annotations "float" on top of the dispalyed image. To save both the
% annotations and the displayed image into a new image, use the trick shown
% here.

fh1 = figure(); % Open a new figure and get its handle
threeboxes = imread('labeled_three_boxes.png'); 
imshow(threeboxes); % Can't quite see the labeled image...

% 'color' the labeled image
rgb_img = label2rgb(threeboxes, 'jet', 'k'); 
imshow(rgb_img); % now much better!

% Now let's try annotate the image
% Find corners and mark the corners
gray_img = rgb2gray(rgb_img);
corners = corner(gray_img);
hold on; plot(corners(:, 1), corners(:, 2), 'ws', 'MarkerFaceColor', [1 1 1]);

% Draw lines on the image
loopxy = [[31 130]; [31 31]; [390 31]; [390 130]; [31 130]];
for i = 2:5
    line(loopxy(i-1:i, 1), loopxy(i-1:i, 2),...
        'LineWidth',4, 'Color', [0, 1, 0]);
end

fh2 = figure; imshow(rgb_img); % Where are all my annotations?

% Use the saveAnnotatedImg (below) to save both the annotations and the
% image. You are welcome to incorporate this function in your code.
annotated_img = saveAnnotatedImg(fh1);

% Check if the two images are of the size size
size(annotated_img)
size(rgb_img)
fh3 = figure; imshow(annotated_img); % The annotations along with the image are saved!

% Close all the figures
delete(fh1); delete(fh2); delete(fh3);

%%
function annotated_img = saveAnnotatedImg(fh)
figure(fh); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fh, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fh);
frame = getframe(fh);
pause(0.5); 
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;

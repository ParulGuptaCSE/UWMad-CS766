function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)
    files = dir(fullfile(focal_stack_dir, '*.jpg'));
    file_names = {files.name};
    
    num_imgs = size(file_names, 2);
    [ht, wid, ~] = size(imread(fullfile(focal_stack_dir, file_names{1})));
    
    rgb_stack = zeros(ht, wid, 3 * num_imgs);
    gray_stack = zeros(ht, wid, num_imgs);
    
    for i = 1 : num_imgs
        rgb_stack(:, :, 3*(i-1)+1 : 3*i) = imread(fullfile(focal_stack_dir, file_names{i}));
        gray_stack(:, :, i) = rgb2gray(imread(fullfile(focal_stack_dir, file_names{i})));
    end
end

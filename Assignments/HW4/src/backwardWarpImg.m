function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)
  
    src_x_pts = (1 : size(src_img, 2));
    src_y_pts = (1 : size(src_img, 1));
    [X, Y] = meshgrid(src_x_pts, src_y_pts);
    src_pts = [X(:) Y(:)];
    transformed_pts = applyHomography(resultToSrc_H, src_pts);
    
    % Computing bounding box:
    min_x = min(transformed_pts(:, 1));
    max_x = max(transformed_pts(:, 1));
    min_y = min(transformed_pts(:, 2));
    max_y = max(transformed_pts(:, 2));
%     fprintf("Canvas size before: %fx%f)\n", dest_canvas_width_height(1), dest_canvas_width_height(2));
    if min_x < 0
        dest_canvas_width_height(1) = ceil(dest_canvas_width_height(1) - min_x);
    end
    if max_x > dest_canvas_width_height(1)
        dest_canvas_width_height(1) = ceil(max_x);
    end
    if min_y < 0
        dest_canvas_width_height(2) = ceil(dest_canvas_width_height(2) - 2 * min_y);% + (max_y - dest_canvas_width_height(2)));
    end
    fprintf("Canvas size after: %fx%f)\n", dest_canvas_width_height(1), dest_canvas_width_height(2));
    
    mask = zeros(dest_canvas_width_height(2), dest_canvas_width_height(1));
    result_img = zeros(dest_canvas_width_height(2), dest_canvas_width_height(1), 3);
    
    for idx = 1 : size(transformed_pts, 1)
        y = transformed_pts(idx, 1);
        x = transformed_pts(idx, 2);
        if min_x < 0
            y = y - min_x;
        end
        if min_y < 0
            x = x - min_y;
        end
        y = round(y);
        x = round(x);
        if x > 0 && x < size(mask, 1) && y > 0 && y < size(mask, 2)
            mask(x, y) = 1;
            result_img(x, y, 1) = src_img(src_pts(idx, 2), src_pts(idx, 1), 1);
            result_img(x, y, 2) = src_img(src_pts(idx, 2), src_pts(idx, 1), 2);
            result_img(x, y, 3) = src_img(src_pts(idx, 2), src_pts(idx, 1), 3);
        else
%             fprintf("(x, y): (%d, %d)\n", x, y);
        end
    end
    
%     class(result_img)
%     [x, y, z] = meshgrid(1 : dest_canvas_width_height(2));
%     [xi, yi, zi] = meshgrid(1 : dest_canvas_width_height(2));
%     result_img = interp3(x, y, z, double(result_img), xi, yi, zi, 'linear');
    figure('Name', 'Backward Warped'); imshow(result_img);
end

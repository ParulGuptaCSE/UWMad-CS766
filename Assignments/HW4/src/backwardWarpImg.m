function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)
    
    mask = zeros(dest_canvas_width_height(2), dest_canvas_width_height(1));
    result_img = zeros(dest_canvas_width_height(2), dest_canvas_width_height(1), 3);
  
    src_x_pts = (1 : size(src_img, 2));
    src_y_pts = (1 : size(src_img, 1));
    [X, Y] = meshgrid(src_x_pts, src_y_pts);
    src_pts = [X(:) Y(:)];
    transformed_pts = applyHomography(resultToSrc_H, src_pts);
    
    for idx = 1 : size(transformed_pts, 1)
        y = round(transformed_pts(idx, 1));
        x = round(transformed_pts(idx, 2));
        if x > 0 && x < size(mask, 1) && y > 0 && y < size(mask, 2)
            mask(x, y) = 1;
            result_img(x, y, 1) = src_img(src_pts(idx, 2), src_pts(idx, 1), 1);
            result_img(x, y, 2) = src_img(src_pts(idx, 2), src_pts(idx, 1), 2);
            result_img(x, y, 3) = src_img(src_pts(idx, 2), src_pts(idx, 1), 3);
        end
    end
    
    % figure(); imshow(mask);
end

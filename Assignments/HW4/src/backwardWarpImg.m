function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)
    
    % Extract different color channels of the src img
    red_s = src_img(:, :, 1);
    gre_s = src_img(:, :, 2);
    blu_s = src_img(:, :, 3);

    dest_ht = dest_canvas_width_height(1);
    dest_wid = dest_canvas_width_height(2);

    [src_ht, src_wid, ~] = size(src_img);

    % Calculate the corresponding source points from dest canvas to
    % interpolate
    [x_coord, y_coord] = meshgrid(1 : dest_ht, 1 : dest_wid);
    src_pts = applyHomography(resultToSrc_H, [x_coord(:), y_coord(:)]);
    
    red_d = interp2(1 : src_wid, 1 : src_ht, red_s, src_pts(:, 1), src_pts(:, 2));
    gre_d = interp2(1 : src_wid, 1 : src_ht, gre_s, src_pts(:, 1), src_pts(:, 2));
    blu_d = interp2(1 : src_wid, 1 : src_ht, blu_s, src_pts(:, 1), src_pts(:, 2));
    
    red_d = reshape(red_d, [dest_wid, dest_ht]);
    gre_d = reshape(gre_d, [dest_wid, dest_ht]);
    blu_d = reshape(blu_d, [dest_wid, dest_ht]);
    
    result_img(:, :, 1) = red_d;
    result_img(:, :, 2) = gre_d;
    result_img(:, :, 3) = blu_d;
    
    result_img(isnan(result_img)) = 0;
    
    % To compute mask, find the corners and fill region with poly2mask
    src_corners = [1, 1; 1, src_ht; src_wid, src_ht; src_wid, 1; 1, 1];
    dest_corners = applyHomography(inv(resultToSrc_H),src_corners);
    
    mask = im2double(poly2mask(dest_corners(:, 1), dest_corners(:, 2), dest_wid, dest_ht));

    result_img = result_img .* cat(3, mask, mask, mask);
end

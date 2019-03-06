function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)
    
    % TODO: Check if we can use horzcat
    single_img = horzcat(orig_img, warped_img);
    fh = figure();
    imshow(single_img); hold on;
    
    % Shift the x coordinates of warped image by the width of original
    % image to plot
    orig_img_wid = size(orig_img, 1);
    dest_pts_nx2(:, 1) = dest_pts_nx2(:, 1) + orig_img_wid;
    for idx = 1 : size(src_pts_nx2, 1)
        line([src_pts_nx2(idx, 1) dest_pts_nx2(idx, 1)], [src_pts_nx2(idx, 2) dest_pts_nx2(idx, 2)], 'lineWidth', 1, 'Color', 'r');
    end
     
    result_img = saveAnnotatedImg(fh);
    delete(fh);
end

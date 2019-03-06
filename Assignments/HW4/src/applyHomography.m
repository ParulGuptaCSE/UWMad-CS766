function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)
%     Swap x, y with y, x due to MATLAB convention
%     src_pts_nx2 = src_pts_nx2(:, [2, 1]);
    
    n_points = size(src_pts_nx2, 1);
    src_pts_nx2 = horzcat(src_pts_nx2, ones(n_points, 1));
    transformed_pts = H_3x3 * src_pts_nx2';
    transformed_pts = transformed_pts';
    dest_pts_nx2 = transformed_pts(:, 1:2) ./ transformed_pts(:, 3);
    
%     dest_pts_nx2 = dest_pts_nx2(:, [2, 1]);
end

function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

    sub_col_1to3 = horzcat(src_pts_nx2, ones(4, 1));
    zeros_1to3 = zeros(4, 3);
    % The below statement interleaves rows of two matrices
    col_1to3 = reshape([sub_col_1to3(:) zeros_1to3(:)]', 2 * size(sub_col_1to3, 1), []);
    col_4to6 = reshape([zeros_1to3(:) sub_col_1to3(:)]', 2 * size(sub_col_1to3, 1), []);
    
    xs = src_pts_nx2(:, 1);
    ys = src_pts_nx2(:, 2);
    xd = dest_pts_nx2(:, 1);
    yd = dest_pts_nx2(:, 2);
    sub_col7_xsxd = xs .* xd;
    sub_col7_xsyd = xs .* yd;
    col_7 = reshape([sub_col7_xsxd(:) sub_col7_xsyd(:)]', 2 * size(sub_col7_xsxd, 1), []);
    
    sub_col8_xdys = ys .* xd;
    sub_col8_ysyd = ys .* yd;
    col_8 = reshape([sub_col8_xdys(:) sub_col8_ysyd(:)]', 2 * size(sub_col8_xdys, 1), []);
    
    col_9 = reshape([xd(:) yd(:)]', 2 * size(xd, 1), []);
    
    % format shortG     % this ensures numbers are printed with their
    % actual values and not in scientific notation
    A = horzcat(col_1to3, col_4to6, -1 .* col_7, -1 .* col_8, -1 .* col_9);
    
    [V, ~] = eig(A' * A);

    % Each consecutive 3 values correspond to a row. Reshape and transpose
    % to obtain the same
    H_3x3 = reshape(V(:, 1), 3, 3)';
end

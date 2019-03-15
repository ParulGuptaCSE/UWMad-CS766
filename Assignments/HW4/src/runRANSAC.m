function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
    rng(0, 'twister');
    random_sample_indices = randi([1, size(Xs, 1)], 1, ransac_n * 4);
    inliers_id = zeros(1);
    for iter = 1 : ransac_n
        x_src = Xs(random_sample_indices(iter : iter + 3), :);
        x_dest = Xd(random_sample_indices(iter : iter + 3), :);
        H_3x3 = computeHomography(x_src, x_dest);
        
        inliers_idx = getInliers(H_3x3, Xs, Xd, eps);
        if size(inliers_idx, 2) > size(inliers_id, 2)
            H = H_3x3;
            inliers_id = inliers_idx;
        end
    end
end

function inliers_idx = getInliers(H, x_s, x_d, err)
    transformed_pts = applyHomography(H, x_s);
    inliers_idx = zeros(size(x_d, 1));
    inl_idx = 1;
    for idx = 1 : size(x_d, 1)
        l2_norm = norm(transformed_pts(idx, :) - x_d(idx, :));
        if l2_norm < err
            inliers_idx(inl_idx) = idx;
            inl_idx = inl_idx + 1;
        end
    end
    inliers_idx = inliers_idx(1 : inl_idx - 1);
end

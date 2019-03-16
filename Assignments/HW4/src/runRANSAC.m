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
    l2_norm = vecnorm(transformed_pts - x_d, 2, 2);
    inliers_idx = find(l2_norm < err)';
end

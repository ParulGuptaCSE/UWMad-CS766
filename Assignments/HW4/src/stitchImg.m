function stitched_img = stitchImg(varargin)
    
%     reference_img = ceil(nargin / 2);
    img_left = varargin{1}; img_c = varargin{2}; img_right = varargin(3);
    
    [xs, xd] = genSIFTMatches(img_left, img_c);
    % xs and xd are the centers of matched frames
    % xs and xd are nx2 matrices, where the first column contains the x
    % coordinates and the second column contains the y coordinates

    before_img = showCorrespondence(img_left, img_c, xs, xd);
%     figure('Name', 'Before RANSAC'), imshow(before_img);
%     imwrite(before_img, 'before_ransac.png');

    % Use RANSAC to reject outliers
    ransac_n = 200;      % Max number of iteractions
    ransac_eps = 10;   % Acceptable alignment error 

    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);

    after_img = showCorrespondence(img_left, img_c, xs(inliers_id, :), xd(inliers_id, :));
%     figure('Name', 'After RANSAC'), imshow(after_img);
%     imwrite(after_img, 'after_ransac.png');

    dest_canvas_width_height = [size(img_c, 2), size(img_c, 1)];
    [mask, res_img] = backwardWarpImg(img_left, H_3x3, dest_canvas_width_height);
    figure('Name', 'After backward warping'), imshow(res_img);
    
    % Bounding box:
    extra_wid = size(mask, 2) - size(img_c, 2);
    extra_ht = size(mask, 1) - size(img_c, 1);
    if extra_wid > 0
        img_c = horzcat(zeros(size(img_c, 1), extra_wid, 3), img_c);
    end
    if extra_ht > 0
        img_c = vertcat(zeros(ceil(extra_ht / 2), size(img_c, 2), 3), img_c, zeros(floor(extra_ht / 2), size(img_c, 2), 3));
    end
    figure('Name', 'Center with bounding box'), imshow(img_c);
    
    fprintf("Size of mask: %dx%d\nSize of imgc: %dx%dx%d\n", size(mask), size(img_c));
%     figure('Name', 'Mask'), imshow(mask);
    mask = ~mask;
    % Superimpose the image
    result = img_c .* cat(3, mask, mask, mask) + res_img;
    figure('Name', 'Blending'), imshow(result);
    
    stitched_img = blendImagePair(res_img, mask, img_c, mask, 'overlay');
    figure('Name', 'After Blending'), imshow(stitched_img);
end

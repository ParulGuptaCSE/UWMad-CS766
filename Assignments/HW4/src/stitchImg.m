function stitched_img = stitchImg(varargin)
    % RANSAC parameters:
    ransac_n = 30;         % Max number of iteractions
    ransac_eps = 2;        % Acceptable alignment error 

    reference_img = varargin{ceil(nargin / 2)};
    for img_idx = 1 : nargin
        if img_idx ~= ceil(nargin / 2)
            img = varargin{img_idx};
            
            [xs, xd] = genSIFTMatches(img, reference_img);
            
            [~, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
            
            [img_ht, img_wid, ~] = size(img);
            src_corners = [1, 1; img_wid, 1; img_wid, img_ht; 1, img_ht];
            dest_corners = applyHomography(H_3x3, src_corners);
            
            % Compute the bounding box for destination img:
            % If img is left to center, left append zeros.
            % Else, right append
            tx = 0; ty = 0;
            if img_idx < ceil(nargin / 2)
                min_x = round(min(dest_corners(:, 1)));
                if min_x < 0
                    % fprintf("Extending left\n");
                    tx = -min_x;
                    reference_img = horzcat(zeros(size(reference_img, 1), -min_x, 3), reference_img);
                end
            else
                max_x = round(max(dest_corners(:, 1)));
                if max_x > size(reference_img, 2)
                    % fprintf("Extending right\n");
                    reference_img = horzcat(reference_img, zeros(size(reference_img, 1), max_x - size(reference_img, 2), 3));
                end
            end
            min_y = round(min(dest_corners(:, 2)));
            max_y = round(max(dest_corners(:, 2)));
            initial_ref_ht = size(reference_img, 1);
            if min_y < 0
                % fprintf("Extending up\n");
                ty = -min_y;
                reference_img = vertcat(zeros(-min_y, size(reference_img, 2), 3), reference_img);
            end
            if max_y > initial_ref_ht
                % fprintf("Extending down\n");
                reference_img = vertcat(reference_img, zeros(max_y - initial_ref_ht, size(reference_img, 2), 3));
            end
            
            dest_canvas_wid_ht = [size(reference_img, 2), size(reference_img, 1)];
            % figure('Name', 'Reference Img'), imshow(reference_img);
            
            % The new homography = translation homography * old homography
            H_new = [1, 0, tx; 0, 1, ty; 0, 0, 1] * H_3x3;
            
            [mask, res_img] = backwardWarpImg(img, inv(H_new), dest_canvas_wid_ht);
            % figure('Name', 'Warped img'), imshow(res_img);
            mask_ref = reference_img(:, :, 1);
            mask_ref(reference_img(:, :, 1) > 0) = 1;
            % figure('Name', 'Mask'), imshow(mask);
            % figure('Name', 'Mask Ref'), imshow(mask_ref);
            reference_img = blendImagePair(res_img, mask, reference_img, mask_ref, 'blend');
            reference_img(isnan(reference_img)) = 0;
            % figure('Name', 'After Blending'), imshow(reference_img);
        end
    end
    stitched_img = reference_img;
end

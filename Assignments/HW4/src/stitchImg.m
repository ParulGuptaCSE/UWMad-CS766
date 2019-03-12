function stitched_img = stitchImg(varargin)
    % RANSAC parameters:
    ransac_n = 200;         % Max number of iteractions
    ransac_eps = 10;        % Acceptable alignment error 

    reference_img = varargin{ceil(nargin / 2)};
    
    for img_idx = 1 : nargin
        if img_idx ~= ceil(nargin / 2)
            img = varargin{img_idx};
            
            [xs, xd] = genSIFTMatches(img, reference_img);
            
            [inliers, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
            
            dest_canvas_wid_ht = [size(reference_img, 2), size(reference_img, 1)];
            [mask, res_img] = backwardWarpImg(img, H_3x3, dest_canvas_wid_ht);
            
            % Extending the canvas size if image is beyond current canvas
            extra_wid = size(mask, 2) - size(reference_img, 2);
            if extra_wid > 0
                % If the image is to the left of reference img, extend canvas
                % on the left. Else, right
                if img_idx < ceil(nargin / 2)
                    reference_img = horzcat(zeros(size(reference_img, 1), extra_wid, 3), reference_img);
                else
                    reference_img = horzcat(reference_img, zeros(size(reference_img, 1), extra_wid, 3));
                end
            end
            extra_ht = size(mask, 1) - size(reference_img, 1);
            if extra_ht > 0
                reference_img = vertcat(zeros(ceil(extra_ht / 2), size(reference_img, 2), 3), reference_img, zeros(floor(extra_ht / 2), size(reference_img, 2), 3));
            end
            figure('Name', 'Center with bounding box'), imshow(reference_img);

            fprintf("Size of mask: %dx%d\nSize of imgc: %dx%dx%d\n", size(mask), size(reference_img));
        %     figure('Name', 'Mask'), imshow(mask);
            mask = ~mask;
            % Superimpose the image
            reference_img = reference_img .* cat(3, mask, mask, mask) + res_img;
            figure('Name', 'Blending'), imshow(reference_img);

%             stitched_img = blendImagePair(res_img, mask, reference_img, mask, 'overlay');
%             figure('Name', 'After Blending'), imshow(stitched_img);
        end
    end
    stitched_img = reference_img;
end

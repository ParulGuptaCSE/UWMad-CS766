function trackingTester(data_params, tracking_params)
    img = imread(fullfile(data_params.data_dir, data_params.genFname(data_params.frame_ids(1))));
    % figure, imshow(img);
    
    src_template = img(tracking_params.rect(2) : tracking_params.rect(2) + tracking_params.rect(4), tracking_params.rect(1) : tracking_params.rect(1) + tracking_params.rect(3), :);
    % figure, imshow(src_template);
    
    [src_temp_ind, src_temp_map] = rgb2ind(src_template, 32);
    src_temp_hist = histc(src_temp_ind(:), 1:tracking_params.bin_n);
    
    obj_rect = tracking_params.rect;
    
    for i = data_params.frame_ids
        dest_search_img = imread(fullfile(data_params.data_dir, data_params.genFname(i)));
        [ht, wid, ~] = size(dest_search_img);
        dest_x_strt = max(1, obj_rect(1) - tracking_params.search_half_window_size);
        dest_x_end = min(wid, obj_rect(1) + obj_rect(3) + tracking_params.search_half_window_size);
        dest_y_strt = max(1, obj_rect(2) - tracking_params.search_half_window_size);
        dest_y_end = min(ht, obj_rect(2) + obj_rect(4) + tracking_params.search_half_window_size);
        
        search_window = dest_search_img(dest_y_strt:dest_y_end, dest_x_strt:dest_x_end, :);
        % figure, imshow(search_window);
        
        search_windows(:, :, 1) = im2col(search_window(:, :, 1), [obj_rect(4), obj_rect(3)]);
        search_windows(:, :, 2) = im2col(search_window(:, :, 2), [obj_rect(4), obj_rect(3)]);
        search_windows(:, :, 3) = im2col(search_window(:, :, 3), [obj_rect(4), obj_rect(3)]);
        similarity = zeros(size(search_window, 2), 1);
        for j = 1 : size(search_windows, 2)
            % figure, imshow(curr_window);
            curr_wind_ind = rgb2ind(search_windows(:, j, :), src_temp_map);
            curr_wind_hist = histc(curr_wind_ind(:), 1:tracking_params.bin_n);
            
            similarity(j) = norm(src_temp_hist - curr_wind_hist);
        end
        [~, idx] = min(similarity);
        
        % TODO: write comments for this formula
        denom = size(search_window, 1) - obj_rect(4) + 1;
        rect_x = ceil(idx / denom) + dest_x_strt;
        rect_y = mod(idx, denom) + dest_y_strt;
        if rect_y == dest_y_strt
            rect_y = denom + dest_y_strt;
        end
        
        obj_rect = [rect_x, rect_y, obj_rect(3), obj_rect(4)];
        res = drawBox(dest_search_img, obj_rect, [0, 255, 0], 1);
        % fig = figure; imshow(res);
        imwrite(res, fullfile(data_params.out_dir, data_params.genFname(i)));
        % close(fig);
    end
end

function trackingTester(data_params, tracking_params)
    img = imread(fullfile(data_params.data_dir, data_params.genFname(data_params.frame_ids(1))));
    figure, imshow(img);
    
    src_template = img(tracking_params.rect(2) : tracking_params.rect(2) + tracking_params.rect(4), tracking_params.rect(1) : tracking_params.rect(1) + tracking_params.rect(3), :);
    figure, imshow(src_template);
    
    [src_temp_ind, src_temp_map] = rgb2ind(src_template, 32);
    src_temp_hist = histc(src_temp_ind(:), 1:tracking_params.bin_n);
    
    for i = data_params.frame_ids
        dest_search_img = imread(fullfile(data_params.data_dir, data_params.genFname(i)));
        dest_img_r = dest_search_img(:, :, 1);
        dest_img_g = dest_search_img(:, :, 2);
        dest_img_b = dest_search_img(:, :, 3);
        
        dest_windows_r = im2col(dest_img_r, [tracking_params.rect(4), tracking_params.rect(3)]);
        dest_windows_g = im2col(dest_img_g, [tracking_params.rect(4), tracking_params.rect(3)]);
        dest_windows_b = im2col(dest_img_b, [tracking_params.rect(4), tracking_params.rect(3)]);
        similarity = zeros(size(dest_windows_r, 2), 1);
        for j = 1 : size(dest_windows_r, 2)
            curr_window_r = reshape(dest_windows_r(:, j), [tracking_params.rect(4), tracking_params.rect(3)]);
            curr_window_g = reshape(dest_windows_g(:, j), [tracking_params.rect(4), tracking_params.rect(3)]);
            curr_window_b = reshape(dest_windows_b(:, j), [tracking_params.rect(4), tracking_params.rect(3)]);
            curr_window = cat(3, curr_window_r, curr_window_g, curr_window_b);
            % figure, imshow(curr_window);
            curr_wind_ind = rgb2ind(curr_window, src_temp_map);
            curr_wind_hist = histc(curr_wind_ind(:), 1:tracking_params.bin_n);
            
            similarity(j) = norm(src_temp_hist - curr_wind_hist);
        end
        [~, idx] = min(similarity);
        window_r = reshape(dest_windows_r(:, idx), [tracking_params.rect(4), tracking_params.rect(3)]);
        window_g = reshape(dest_windows_g(:, idx), [tracking_params.rect(4), tracking_params.rect(3)]);
        window_b = reshape(dest_windows_b(:, idx), [tracking_params.rect(4), tracking_params.rect(3)]);
        window = cat(3, window_r, window_g, window_b);
        figure, imshow(window);
    end
end

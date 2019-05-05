function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)
    [ht, wid] = size(img1);
    flow_pos = [];
    flow_vec = [];
    c = 1;
    for x = round(wid / (grid_MN(2) + 1)) + 1 : round(wid / (grid_MN(2) + 1)) : wid - round(wid / (grid_MN(2) + 1))
        r = 1;
        for y = round(ht / (grid_MN(1) + 1)) + 1 : round(ht / (grid_MN(1) + 1)) : ht
            src_x_strt = max(1, x - template_radius);
            src_y_strt = max(1, y - template_radius);
            src_x_end = min(wid, x + template_radius);
            src_y_end = min(ht, y + template_radius);
            
            dest_x_strt = max(1, x - win_radius);
            dest_y_strt = max(1, y - win_radius);
            dest_x_end = min(wid, x + win_radius);
            dest_y_end = min(ht, y + win_radius);
            
            src_template = img1(src_y_strt:src_y_end, src_x_strt:src_x_end);
            dest_window = img2(dest_y_strt:dest_y_end, dest_x_strt:dest_x_end);
            cross_corr = normxcorr2(src_template, dest_window);
            % Remove the extra padding added by normxcorr2 function
            cross_corr = cross_corr(size(src_template, 1) : size(cross_corr, 1) - size(src_template, 1), size(src_template, 2) : size(cross_corr, 2) - size(src_template, 2));
            [y_match, x_match] = find(cross_corr == max(cross_corr(:)));
            
            % Transform the coordinates to original frame of reference
            % while finding the optical flow vector direction
            flow_pos = [flow_pos; y, x];
            flow_vec = [flow_vec; x_match - (src_x_strt - dest_x_strt + 1), y_match - (src_y_strt - dest_y_strt + 1)];
            r = r + 1;
        end
        c = c + 1;
    end
    
    % Draw the needle plot on img1.
    fig = figure;
    imshow(img1);
    hold on;
    quiver(flow_pos(:, 2), flow_pos(:, 1), flow_vec(:, 1), flow_vec(:, 2), 0, 'filed', 'r');
    result = saveAnnotatedImg(fig);
    close(fig);
end

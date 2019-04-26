function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)
    [ht, wid] = size(img1);
    result = zeros(ht, wid, 2);
    
    c = 1;
    for x = round(wid / (grid_MN(2) + 1)) + 1 : round(wid / (grid_MN(2) + 1)) : wid
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
            % figure('Name', 'Source template'), imshow(src_template);
            dest_window = img2(dest_y_strt:dest_y_end, dest_x_strt:dest_x_end);
            cross_corr = normxcorr2(src_template, dest_window);
            [y_match, x_match] = find(cross_corr == max(cross_corr(:)));
            
            % Transform the coordinates to original frame of reference
            x_match = x_match(1) + dest_x_strt;
            y_match = y_match(1) + dest_y_strt;
            result(y, x, :) = [x_match - x, y_match - y];
            r = r + 1;
        end
        c = c + 1;
    end
    
    fig = figure;
    imshow(img1);
    hold on;
    for y = round(ht / (grid_MN(1) + 1)) + 1 : round(ht / (grid_MN(1) + 1)) : ht
        for x = round(wid / (grid_MN(2) + 1)) + 1 : round(wid / (grid_MN(2) + 1)) : wid
            quiver(x, y, result(y, x, 1), result(y, x, 2), 'filed', 'y', 'MaxHeadSize', 1, 'LineWidth', 0.7);
        end
    end
    result = saveAnnotatedImg(fig);
    close(fig);
end

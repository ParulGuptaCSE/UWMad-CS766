function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)
    [ht, wid] = size(img1);
    result = zeros(grid_MN(1), grid_MN(2), 2);
    
    for x = 1 : grid_MN(2)
        for y = 1 : grid_MN(1)
            if x - win_radius > 0
                src_x_strt = x - win_radius;
            else
                src_x_strt = 1;
            end
            if y - win_radius > 0
                src_y_strt = y - win_radius;
            else
                src_y_strt = 1;
            end
            if x + win_radius < wid
                src_x_end = x + win_radius;
            else
                src_x_end = wid;
            end
            if y + win_radius < ht
                src_y_end = y + win_radius;
            else
                src_y_end = ht;
            end
            
            if x - template_radius > 0
                dest_x_strt = x - template_radius;
            else
                dest_x_strt = 1;
            end
            if y - template_radius > 0
                dest_y_strt = y - template_radius;
            else
                dest_y_strt = 1;
            end
            if x + template_radius < wid
                dest_x_end = x + template_radius;
            else
                dest_x_end = wid;
            end
            if y + template_radius < ht
                dest_y_end = y + template_radius;
            else
                dest_y_end = ht;
            end
            
            src_template = img1(src_y_strt:src_y_end, src_x_strt:src_x_end);
            dest_template = img2(dest_y_strt:dest_y_end, dest_x_strt:dest_x_end);
            cross_corr = normxcorr2(src_template, dest_template);
            [y_match, x_match] = find(cross_corr == max(cross_corr(:)));
            result(y, x, :) = [y_match - y, x_match - x];
        end
    end
end

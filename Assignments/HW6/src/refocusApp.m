function refocusApp(rgb_stack, depth_map)
    [ht, wid] = size(depth_map);
    
    figure('Name', 'Refocusing App'), imshow(rgb_stack(:, :, 1:3));
    
    [y, x] = ginput(1);
    x = round(x); y = round(y);
    while y > 0 && y < wid && x > 0 && x < ht
        best_idx = depth_map(x, y);
        imshow(rgb_stack(:, :, 3*(best_idx-1)+1 : 3*best_idx));
        
        [y, x] = ginput(1);
        x = round(x); y = round(y);
    end
end

function refocusApp(rgb_stack, depth_map)
    [ht, wid] = size(depth_map);
    
    figure, imshow(rgb_stack(:, :, 1:3));
    
    [y, x] = round(ginput(1));
    while y > 0 && y < wid && x > 0 && x < ht
        best_idx = depth_map(x, y);
        imshow(rgb_stack(:, :, 3*(best_idx-1)+1 : 3*best_idx));
        
        [y, x] = round(ginput(1));
    end
end

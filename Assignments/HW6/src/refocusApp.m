function refocusApp(rgb_stack, depth_map)
    [ht, wid] = size(depth_map);
    padding = 40;
    
    canvas = padarray(rgb_stack(:, :, 1:3), [padding padding], 255, 'both');
    fig = figure('Name', 'Refocusing App'); imshow(canvas);
    
    [y, x] = ginput(1);
    x = round(x) - padding; y = round(y) - padding;
    while y > 0 && y < wid && x > 0 && x < ht
        best_idx = depth_map(x, y);
        canvas = padarray(rgb_stack(:, :, 3*(best_idx-1)+1 : 3*best_idx), [padding padding], 255, 'both');
        imshow(canvas);
        
        [y, x] = ginput(1);
        x = round(x) - padding; y = round(y) - padding;
    end
    close(fig);
end

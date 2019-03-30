function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)
    light_dirs_5x3 = zeros(size(img_cell, 1), 3);
    for i = 1 : size(img_cell, 1)
        img = im2double(img_cell{i});
        [max_intensity, idx] = max(img(:));
        [max_int_r, max_int_c] = ind2sub(size(img), idx);
        
        dir_x = max_int_c - center(2);
        dir_y = max_int_r - center(1);
        dir_z = sqrt(radius^2 - (dir_x^2 + dir_y^2));
        
        % Let the magnitude be the max intensity
        dir_x = dir_x / (dir_x^2 + dir_y^2 + dir_z^2) * max_intensity;
        dir_y = dir_y / (dir_x^2 + dir_y^2 + dir_z^2) * max_intensity;
        dir_z = dir_z / (dir_x^2 + dir_y^2 + dir_z^2) * max_intensity;
        
        light_dirs_5x3(i, 1) = -dir_x;
        light_dirs_5x3(i, 2) = -dir_y;
        light_dirs_5x3(i, 3) = -dir_z;
    end
end

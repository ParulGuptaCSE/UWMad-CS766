function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)
    
    [img_ht, img_wid] = size(mask);
    normals = zeros(img_ht, img_wid, 3);
    albedo_img = zeros(img_ht, img_wid);
    for r = 1 : img_ht
        for c = 1 : img_wid
            if mask(r, c) > 0
                I = double([img_cell{1}(r, c); img_cell{2}(r, c); img_cell{3}(r, c); img_cell{4}(r, c); img_cell{5}(r, c)]);
                S = light_dirs;
                
                N = inv(S' * S) * S' * I;
                normals(r, c, :) = N / norm(N);
                albedo_img(r, c) = norm(N);
            end
        end
    end
    
    % Scaling albedo img
    albedo_img = im2double(albedo_img);
    max_alb = max(albedo_img(:));
    albedo_img = albedo_img / max_alb;
end

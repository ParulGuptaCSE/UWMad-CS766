function index_map = generateIndexMap(gray_stack, w_size)
    num_imgs = size(gray_stack, 3);
    focus_map = zeros(size(gray_stack));
    
    lap_filter = fspecial('laplacian');
    avg_filter = fspecial('average', [2 * w_size, 2 * w_size]);
    
    for i = 1 : num_imgs
        % grad2_x = gradient_x(gradient_x(gray_stack(:, :, i)));
        % grad2_y = gradient_y(gradient_y(gray_stack(:, :, i)));
        
        % laplacian = grad2_x .* grad2_x + grad2_y .* grad2_y;
        
        laplacian_img = imfilter(gray_stack(:, :, i), lap_filter);
        focus_map(:, :, i) = imfilter(laplacian_img, avg_filter);
    end
    
    [~, index_map] = max(focus_map, [], 3);
end

function grad_x = gradient_x(gray_img)
    [ht, wid] = size(gray_img);
    grad_x = horzcat(gray_img(:, 2:wid) - gray_img(:, 1:wid-1), zeros(ht, 1));
end

function grad_y = gradient_y(gray_img)
    [ht, wid] = size(gray_img);
    grad_y = vertcat(gray_img(2:ht, :) - gray_img(1:ht-1, :), zeros(1, wid));
end

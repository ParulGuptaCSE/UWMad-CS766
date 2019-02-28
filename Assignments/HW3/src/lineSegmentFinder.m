function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    edge_img = imread('edge_hough_1.png');
    [theta_max, rho_max] = size(hough_img);
    [ht, wid] = size(orig_img);
    max_rho = sqrt(ht^2 + wid^2);
    fh = figure; imshow(orig_img);
    hold on;
    
                    
    % Convolve with a circular filter of radius 3 to find
    % if any pixels exist in the edges image
    filter = fspecial('disk', 6);
    % Perform convolution 
    convolved_img = imfilter(edge_img, filter, 'conv', 'replicate');
    % imshow(convolved_img);
    for theta = 1 : theta_max
        for rho = 1 : rho_max
            % fprintf("%d %d\n", theta, rho);
            if hough_img(theta, rho) > hough_threshold
                theta_val = theta * 180 / theta_max;
                rho_val = max_rho * (rho / (rho_max / 2) - 1);
                
                for x = 1 : ht
                    y = (x * tand(theta_val) + rho_val * secd(theta_val));
                    % fprintf("%d %f\n", x, y);
                    round_y = round(y);
                    if round_y > 0 && round_y < wid && convolved_img(x, round_y) > 0
                        plot(y, x, '.', 'Color', 'g');
                    end
                end
            end
        end
    end
    
    
    cropped_line_img = saveAnnotatedImg(fh);
end

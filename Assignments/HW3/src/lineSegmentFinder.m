function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    edge_img = im2double(edge(orig_img, 'sobel', .06));
    % imshow(edge_img);
    [theta_max, rho_max] = size(hough_img);
                    
    % Convolve with a circular filter of radius 3 to find
    % if any pixels exist in the edges image
    filter = ones(7, 7);  % fspecial('disk', 10);
    % Perform convolution 
    % convolved_img = imfilter(edge_img, filter, 'conv', 'replicate');
    convolved_img = bwmorph(edge_img, 'dilate', 1);
    % fh_c = figure; imshow(convolved_img);
    
    [ht, wid] = size(orig_img);
    max_rho = sqrt(ht^2 + wid^2);
    fh = figure; imshow(orig_img);
    hold on;
    
    for theta = 1 : theta_max
        for rho = 1 : rho_max
            % fprintf("%d %d\n", theta, rho);
            if hough_img(theta, rho) > hough_threshold
                theta_val = theta * 180 / theta_max;
                rho_val = max_rho * (rho / (rho_max / 2) - 1);
                
                x = 1;
                while x <= ht
                    y = (x * tand(theta_val) + rho_val * secd(theta_val));
                    % fprintf("%d %f\n", x, y);
                    round_y = round(y);
                    X = [0 0];
                    Y = [0 0];
                    if round_y > 0 && round_y < wid && convolved_img(round(x), round_y) > 0
                        X(1) = x;
                        Y(1) = y;
                        x = x + .1;
                        y = (x * tand(theta_val) + rho_val * secd(theta_val));
                        round_y = round(y);
                        while x <= ht && round_y > 0 && round_y < wid && convolved_img(round(x), round_y) > 0
                            x = x + .1;
                            y = (x * tand(theta_val) + rho_val * secd(theta_val));
                            round_y = round(y);
                        end
                        X(2) = x;
                        Y(2) = y;
                        % fprintf("(%d, %d) (%d, %d)\n", X(1), Y(1), X(2), Y(2));
                        plot(Y, X, 'Color', 'g');
                    end
                    x = x + .1;
                end
            end
        end
    end
%     corners = corner(orig_img);
%     hold on; plot(corners(:, 1), corners(:, 2), 'ws', 'MarkerFaceColor', [1 1 1]);
    
    
    cropped_line_img = saveAnnotatedImg(fh);
end

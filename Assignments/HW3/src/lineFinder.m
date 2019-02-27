function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    [theta_max, rho_max] = size(hough_img);
    [ht, wid] = size(orig_img);
    max_rho = sqrt(ht^2 + wid^2);
    fh = figure; imshow(orig_img);
    hold on;
    
    for theta = 1 : theta_max
        for rho = 1 : rho_max
            if hough_img(theta, rho) > hough_threshold
                theta_val = theta * 180 / theta_max;
                rho_val = rho * max_rho / rho_max;
                fprintf("rho = %f theta = %f\n", rho_val, theta_val);
                x = 1 : ht;
                y = x * tand(theta_val) + rho_val * secd(theta_val);
                plot(y, x, 'Color', 'g');
%                 X = [rho_val / cosd(theta_val), 0];
%                 Y = [0 -rho_val / sind(theta_val)];
                % Y = [-rho / sind(theta), 0];
                % X = [0, rho / cosd(theta)];
                
                % fprintf("(%d, %d) (%d, %d)\n", X(1), Y(1), X(2), Y(2));
                % line(X, Y, 'LineWidth', 4, 'Color', [0, 1, 0]);
                
%                 xlim = get(gca, 'XLim');
%                 m = (Y(2) - Y(1)) / (X(2) - X(1));
%                 n = Y(2) * m - X(2);
%                 y1 = m * xlim(1) + n;
%                 y2 = m * xlim(2) + n;
%                 
%                 line([xlim(1), xlim(2)], [y1, y2], 'LineWidth', 1, 'Color', [0, 1, 0]);
%                 line(X, Y, 'LineWidth', 1, 'Color', [0, 1, 0]);
%                 line([y1 y2], [xlim(1) xlim(2)], 'LineWidth', 1, 'Color', [0, 1, 0]);
            end
        end
    end
    
    line_detected_img = saveAnnotatedImg(fh);
end

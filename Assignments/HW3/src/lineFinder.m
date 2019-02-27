function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    [theta_max, rho_max] = size(hough_img);
    fh = figure; imshow(orig_img);
    hold on;
    
    for theta = 1 : theta_max
        for rho = 1 : rho_max
            if hough_img(theta, rho) > hough_threshold
                X = [rho / cosd(theta), 0];
                Y = [0 -rho / sind(theta)];
                % Y = [-rho / sind(theta), 0];
                % X = [0, rho / cosd(theta)];
                
                % fprintf("(%d, %d) (%d, %d)\n", X(1), Y(1), X(2), Y(2));
                % line(X, Y, 'LineWidth', 4, 'Color', [0, 1, 0]);
                
%                 xlim = get(gca, 'XLim');
%                 m = (Y(2) - Y(1)) / (X(2) - X(1));
%                 n = Y(2) * m - X(2);
%                 y1 = m * xlim(1) + n;
%                 y2 = m * xlim(2) + n;
                
%                 line([xlim(1), xlim(2)], [y1, y2], 'LineWidth', 1, 'Color', [0, 1, 0]);
                line(X, Y, 'LineWidth', 1, 'Color', [0, 1, 0]);
                % line([xlim(1) xlim(2)], [y1 y2], 'LineWidth', 1, 'Color', [0, 1, 0]);
            end
        end
    end
    
    line_detected_img = saveAnnotatedImg(fh);
end

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
                rho_val = max_rho * (rho / (rho_max / 2) - 1);
                fprintf("rho = %f theta = %f\n", rho_val, theta_val);
                x = 1 : ht;
                y = x * tand(theta_val) + rho_val * secd(theta_val);
                plot(y, x, 'Color', 'g');
            end
        end
    end
    
    line_detected_img = saveAnnotatedImg(fh);
end

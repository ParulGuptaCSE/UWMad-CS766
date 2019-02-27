function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    hough_img = zeros(theta_num_bins, rho_num_bins);
    
    [ht, wid] = size(img);
    
    max_theta = 180;
    max_rho = sqrt(ht^2 + wid^2);
    
    for row = 1 : ht
        for col = 1 : wid
            if img(row, col) ~= 0   % If it's an edge pixel
                for theta_bin_idx = 1 : theta_num_bins
                    theta = theta_bin_idx * max_theta / theta_num_bins;
                    rho = col * cosd(theta) - row * sind(theta);
                    rho_bin_idx = abs(ceil(rho * rho_num_bins / max_rho));
                    % fprintf("True vals: (%f, %f)\n", theta, rho);
                    % fprintf("Bin vals: (%d, %d)\n", theta_bin_idx, rho_bin_idx);
                    if rho_bin_idx > 0 && rho_bin_idx <= rho_num_bins
                        hough_img(theta_bin_idx, rho_bin_idx) = hough_img(theta_bin_idx, rho_bin_idx) + 1;
                    end
                end
            end
        end
    end
    
    % fprintf("Max accumulated val: %d\n", max(hough_img(:)));
    % Normalize the values accumulated:
    min_val = min(hough_img(:));
    max_val = max(hough_img(:));
    for row = 1 : theta_num_bins
        for col = 1 : rho_num_bins
            hough_img(row, col) = ceil((hough_img(row, col) - min_val) / (max_val - min_val) * 255);
        end
    end
    
    imshow(hough_img);
end
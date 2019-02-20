function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
    [obj_props, ~] = compute2DProperties(orig_img, labeled_img);
    round_diff_thres = .02625;  % threshold for difference in roundedness to match
    E_min_percent_thres = 15.0; % threshold for difference in E_min percent to match
    
    fh_fin = figure('Name', 'Final');
    imshow(orig_img);
    
    size_objs = size(obj_props);
    size_db_objs = size(obj_db);
    for obj = 1 : size_objs(2)
        props = obj_props(:, obj);
        
        for db_obj = 1 : size_db_objs(2)
            db_props = obj_db(:, db_obj);
            
            % Compare objs: true if E_min and roundedness are same
            roundedness_diff = abs(props(6) - db_props(6));
            E_min_percent_diff = abs(props(4) - db_props(4)) / db_props(4) * 100;
            if roundedness_diff < round_diff_thres && E_min_percent_diff < E_min_percent_thres
                %fprintf("Match found\n");
                %fprintf("Db roundedness: %f\tObj roundedness: %f\n", db_props(6), props(6));
                %fprintf("Db E_min: %f\tObj E_min: %f\n", db_props(4), props(4));
                % Plot center and orientation is same obj
                hold on;
                % Plot Center
                plot(props(3), props(2), 'ws', 'MarkerFaceColor', [1 0 1]);
                % Plot Orientation Line
                line_len = 30;
                line([props(3) props(3) + line_len * sind(props(5))], [props(2) props(2) + line_len * cosd(props(5))],...
                    'LineWidth', 1.5, 'Color', [1, 0, 0]);
                %     line([y_center y_center + line_len * cosd(orientation)], [x_center x_center + line_len * sind(orientation)],...
                %         'LineWidth', 1.5, 'Color', [1, 0, 0]);
            end
        end
    end
    
    output_img = saveAnnotatedImg(fh_fin);
    fh_out = figure; imshow(output_img);
    delete(fh_fin);
end

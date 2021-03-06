function [db, out_img] = compute2DProperties(orig_img, labeled_img)
    obj_count = max(labeled_img(:));
    props_count = 7;
    [ht, wid] = size(orig_img);

    db = zeros(props_count, obj_count);

    fh1 = figure();
    imshow(orig_img);

    for obj_label = 1 : obj_count
        x_center = 0;
        y_center = 0;
        area = 0;

        for row = 1 : ht
            for col = 1 : wid
                if labeled_img(row, col) == obj_label
                    x_center = x_center + row;
                    y_center = y_center + col;
                    area = area + 1;
                end
            end
        end

        x_center = floor(x_center / area);
        y_center = floor(y_center / area);

        % fprintf("Center: %d %d\n", x_center, y_center);

        % Second moments:
        a = 0;
        b = 0;
        c = 0;
        for row = 1 : ht
            for col = 1 : wid
                if labeled_img(row, col) == obj_label
                    a = a + ((row - x_center) ^ 2);
                    b = b + (2 * (row - x_center) * (col - y_center));
                    c = c + ((col - y_center) ^ 2);
                end
            end
        end

        orientation = 0.5 * atand(b / (a - c));

        % fprintf("Orientation: %f\n", orientation);

        % 
        E_Min = a * sind(orientation) ^ 2 - b * sind(orientation) * cosd(orientation) + c * cosd(orientation) ^ 2;
        max_orient = orientation + 90;
        E_Max = a * sind(max_orient) ^ 2 - b * sind(max_orient) * cosd(max_orient) + c * cosd(max_orient) ^ 2;
        if E_Max < E_Min
            temp = E_Min;
            E_Min = E_Max;
            E_Max = temp;
            orientation = orientation + 90;
        end

        % fprintf("Moments: %f %f\n", E_Min, E_Max);

        roundedness = E_Min / E_Max;
        % fprintf("Roundedness: %f\n\n", roundedness);

        db(1, obj_label) = obj_label;
        db(2, obj_label) = x_center;
        db(3, obj_label) = y_center;
        db(4, obj_label) = E_Min;
        db(5, obj_label) = orientation;
        db(6, obj_label) = roundedness;

        % Extra properties
        db(7, obj_label) = area;

        hold on;
        % Plot Center
        plot(y_center, x_center, 'ws', 'MarkerFaceColor', [1 1 1]);
        % Plot Orientation Line
        line_len = 30;
        line([y_center y_center + line_len * sind(orientation)], [x_center x_center + line_len * cosd(orientation)],...
            'LineWidth', 1.5, 'Color', [0, 1, 1]);
    end

    annotated_img = saveAnnotatedImg(fh1);
    fh2 = figure; imshow(annotated_img);
    delete(fh1); delete(fh2);

    imwrite(annotated_img, 'annotated_img_own.png');

    out_img = annotated_img;
end

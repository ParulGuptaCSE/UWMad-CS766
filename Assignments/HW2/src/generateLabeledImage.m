function labeled_img = generateLabeledImage(gray_img, threshold)
    fh = figure();
    imshow(gray_img);

    bw_img = im2bw(gray_img, threshold);
    imshow(bw_img);

    labeled_img = bwlabel(bw_img);
    imshow(labeled_img);

    delete(fh);
end

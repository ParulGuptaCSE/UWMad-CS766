function [center, radius] = findSphere(img)
    bw_img = im2bw(img, 0.0001);
    img_props = regionprops(bw_img, 'Area', 'Centroid');
    
    center = img_props.Centroid;
    radius = sqrt(img_props.Area / pi);
end

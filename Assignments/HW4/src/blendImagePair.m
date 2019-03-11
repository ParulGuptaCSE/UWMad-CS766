function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
%     % mask should be of the type logical
%     mask = ~mask;
%     % Superimpose the image
%     result = bg_img .* cat(3, mask, mask, mask) + dest_img;
%     figure, imshow(result);
%     imwrite(result, 'Van_Gogh_in_Osaka.png');
    
%     fig_wraps = figure('Name', 'Wrapped Src');
%     imshow(wrapped_imgs);
%     fig_masks = figure('Name', 'Mask Src');
%     imshow(masks);
%     
%     fig_wrapd = figure('Name', 'Wrapped Dest');
%     imshow(wrapped_imgd);
%     fig_maskd = figure('Name', 'Mask Dest');
%     imshow(maskd);
    
    
    if strcmp(mode, 'overlay')
%         maskd = logical(maskd);
%         figure('Name', 'Mask Dest');
%         imshow(maskd);
        maskd = ~maskd;
%         figure('Name', 'Invert Mask Dest');
%         imshow(maskd);
        wrapped_imgd = im2double(wrapped_imgd);
        wrapped_imgs = im2double(wrapped_imgs);
%         figure('Name', 'Mask dest img');
%         imshow(maskd);
%         figure('Name', 'Src img');
%         imshow(wrapped_imgs);
%         figure('Name', 'Dest img');
%         imshow(wrapped_imgd);
        out_img = wrapped_imgs .* cat(3, maskd, maskd, maskd) + wrapped_imgd;
%         figure('Name', 'Overlayed img');
%         imshow(out_img);
    elseif strcmp(mode, 'blend')
        masks = horzcat(ones(size(wrapped_imgs, 1), size(wrapped_imgs, 2) / 2), zeros(size(wrapped_imgs, 1), size(wrapped_imgs, 2) / 2));
        maskd = horzcat(zeros(size(wrapped_imgd, 1), size(wrapped_imgd, 2) / 2), ones(size(wrapped_imgd, 1), size(wrapped_imgd, 2) / 2));
        
%         maskd = ~maskd;
%         figure('Name', 'Invert Mask Dest');
%         imshow(maskd);
        maskd = bwdist(maskd);
%         maskd = 1 - maskd;
%         figure('Name', 'BWdist Mask Dest');
%         imshow(maskd);
%         masks = ~masks;
        masks = bwdist(masks);
%         masks = 1 - masks;
        
        wrapped_imgd = im2double(wrapped_imgd);
        wrapped_imgs = im2double(wrapped_imgs);
        
        figure('Name', 'Mask src img');
        imshow(masks);
        figure('Name', 'Mask dest img');
        imshow(maskd);
        figure('Name', 'Src img');
        imshow(wrapped_imgs);
        figure('Name', 'Dest img');
        imshow(wrapped_imgd);
        
%         maskd = logical(maskd);
%         masks = logical(masks);
%         out_img = (wrapped_imgs .* cat(3, maskd, maskd, maskd) + wrapped_imgd);
        out_img = (wrapped_imgs .* cat(3, masks, masks, masks) + wrapped_imgd) + (wrapped_imgd .* cat(3, maskd, maskd, maskd) + wrapped_imgs);% + 0.5 * wrapped_imgd + .5 * wrapped_imgs;
%         out_img = out_img .* cat(3, maskd, maskd, maskd);
%         out_img = out_img .* cat(3, masks, masks, masks);
        
        figure('Name', 'Blended img');
        imshow(out_img);
    end
end

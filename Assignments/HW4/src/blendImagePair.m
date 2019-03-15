function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
    class(wrapped_imgd);
    class(maskd);
    wrapped_imgd = im2double(wrapped_imgd);
    % figure('Name', 'Wrapped imgd'), imshow(wrapped_imgd);
    wrapped_imgs = im2double(wrapped_imgs);
    masks = im2double(masks);
    maskd = im2double(maskd);
    %convert masks and maskd into binary masks
    masks(masks > 0) = 1;
    maskd(maskd > 0) = 1;
    if strcmp(mode, 'overlay')
        maskd = ~maskd;
        out_img = wrapped_imgs .* cat(3, maskd, maskd, maskd) + wrapped_imgd;
    elseif strcmp(mode, 'blend')
        wt_masks = bwdist(~masks);
        wt_maskd = bwdist(~maskd);
        
        wt_masks = wt_masks / max(wt_masks(:));
        wt_maskd = wt_maskd / max(wt_maskd(:));
        
        % figure('Name', 'Weighted masks'), imshow(wt_masks);
        % figure('Name', 'Weighted maskd'), imshow(wt_maskd);
        
        wt_masks = cat(3, wt_masks, wt_masks, wt_masks);
        wt_maskd = cat(3, wt_maskd, wt_maskd, wt_maskd);
        wt_imgs = wrapped_imgs .* wt_masks;
        wt_imgd = wrapped_imgd .* wt_maskd;
        % figure('Name', 'Weighted imgs'), imshow(wt_imgs);
        % figure('Name', 'Weighted imgd'), imshow(wt_imgd);
        % figure('Name', 'Weighted imgs+imgd'), imshow(wt_imgs + wt_imgd);
        % figure('Name', 'Weighted masks+maskd'), imshow(wt_masks + wt_maskd);
        
        out_img = (wt_imgs + wt_imgd) ./ (wt_masks + wt_maskd);
        % figure('Name', 'Out_img'), imshow(out_img);
    end
end

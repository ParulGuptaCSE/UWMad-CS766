function mask = computeMask(img_cell)
    mask = img_cell{1} | img_cell{2} | img_cell{3} | img_cell{4} | img_cell{5};
end

function filteredImage = imgaussfilt(image,sigma)
    filterWidth = 2*ceil(2*sigma)+1;
    filter = fspecial('gaussian',filterWidth,sigma);
    filteredImage = imfilter(image,filter);
end

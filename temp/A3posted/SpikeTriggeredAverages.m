clear
close all

filter = makeImageSquare(32);
figure
imagesc(filter);
colormap gray
title('Filter');

threshold = 340;
thresholdCount = 0; 

responseImage = zeros(32,32);
for i = 1:50000
    Image = rand(32,32);
    innerProduct = sum(sum(filter .* Image));    
    if innerProduct > threshold 
        thresholdCount = thresholdCount + 1;
        sumImage = responseImage + Image;
        responseImage = sumImage;     
    end
end

approximatedFilter = responseImage ./ thresholdCount; 

figure
imagesc(approximatedFilter)
colormap gray
title(['Filter Approximation, Threshold='  num2str(threshold)] );

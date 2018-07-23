%   function remapImage.m
%
%   Remap NxM image so value are int in 0 to 255.
%
%   If image has at least one negative value, then 
%   remap all values so that 0 maps to 127 and the range is within
%   0 to 255.
%   If image values are all positive, then remap 0 to 0 and range is 0 to 255

function vNormalized = remapImageUint8(image)
if min(image(:)) < - 1.0/1028   
    % a hack to avoid small negative floats when all values are supposed to be positive
    vNormalized = uint8(127 + 128*image/max(abs(image(:))) );
else
    vNormalized = uint8(255*(image + 1.0/1028)/max(abs(image(:))) );
end

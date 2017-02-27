function outputImg = LowRankSVDCompressor( img_path, rank)
% open input image and convert from uint8 to double
img = imread(img_path);
%converting to grayscale
if size(img,3)==3
img=rgb2gray(img);
end
img=double(img);

% perform SVD on input image
[U,S,V] = svd(img);

outputImg = U(: , 1:rank)*S(1:rank , 1:rank)*V(: , 1:rank)';




function test(img_path)

%reading the image
img=imread(img_path);
%converting to grayscale
if size(img,3)==3
img=rgb2gray(img);
end
imgD=double(img);
[m , n] = size(imgD);
fileinfo = dir(img_path);
orgSize = fileinfo(1).bytes;

mainfig = figure('Name','SVD Image Compressor','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
tabgroup = uitabgroup(mainfig, 'Position', [.05 .1 .9 .8]);
k=1

% Show full-rank image
tab(k)=uitab(tabgroup,'Title', sprintf('Output Images'));
axes('parent',tab(k));
subplot(2, 4, 1), imshow(uint8(imgD)), title('Full-Rank image');

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = [];
compareSizes = [];

ranks = [200, 100, 50, 30, 20, 10, 3];
for i = 1:length(ranks)
    reducedImg = LowRankSVDCompressor(img_path,ranks(i));
    
    %save reduced img
    imwrite(uint8(reducedImg),strcat('./files/output/Reduced_img_',num2str(ranks(i)),'.jpg'));
    
    %calculate byte size different
    K=imfinfo(strcat('./files/output/Reduced_img_',num2str(ranks(i)),'.jpg'));
    fileinfo = dir(strcat('./files/output/Reduced_img_',num2str(ranks(i)),'.jpg'));
    imgSize = fileinfo(1).bytes
    compareSizes =[compareSizes; imgSize];
    % store errors 
    error=sum(sum((imgD-reducedImg).^2))/m*n;
    dispEr = [dispEr; error];
    
    % Plot approximation
    subplot(2, 4, i + 1), imshow(uint8(reducedImg)), title(sprintf('Rank: %d, Comp: %.2f', ranks(i), imgSize/orgSize));
end

% dislay the error graph
tab(2)=uitab(tabgroup,'Title', sprintf('MSE Error'));
axes('parent',tab(2));
plot(ranks, dispEr);
grid on
xlabel('Number of Singular Values used');
ylabel('Error between compress and original image');

% dislay the error graph
tab(3)=uitab(tabgroup,'Title', sprintf('Compression Factor'));
axes('parent',tab(3));
plot(ranks, compareSizes);
grid on
xlabel('Number of Singular Values used');
ylabel('compress image size / original image size');

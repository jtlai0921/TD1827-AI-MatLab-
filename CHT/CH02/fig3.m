clc;
clear all;
img = imread('2.jpg');
figure,
subplot(2,2,1),
imshow(img); 
title('original');
img=im2bw(img);
img1=edge(img,'sobel'); 
%用SOBEL算子進行邊緣檢驗
subplot(2,2,2),
imshow(img1); 
title('edge');
img2 = bwperim(img,8); 
%用bwperim函數進行輪廓分析
subplot(2,2,3),
imshow(img2); 
title('bwperim');
subplot(2,2,4),
 [B,L] = bwboundaries(img);
imshow(img);
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%一個一個標示邊界像素；用紅色標示，以突出圖形邊界顯示結果； 
end
title('bwboundaries');

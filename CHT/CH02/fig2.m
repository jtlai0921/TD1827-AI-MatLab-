clc;
clear all;
img = imread('2.jpg');
img=im2bw(img);
[B,L] = bwboundaries(img);
figure,
imshow(img);
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end
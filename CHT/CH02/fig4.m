%bwboundaries函數呼叫用法範例
%指定使用連通性的呼叫格式
% 8連通與4連通的比較
clc;
%清楚暫存的MATLAB空間變數
clear all;
%%圖形讀取及二值化
img = imread('2.jpg');
img=im2bw(img);

%%開始繪圖
figure,
%%先繪制使用8連通進行圖形邊界顯示的結果
subplot(1,2,1)
[B,L] = bwboundaries(img,8);
%指定使用8連通進行圖形邊界顯示
imshow(img);
title('8-connected');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end
%再繪制使用4連通進行圖形邊界顯示的結果
subplot(1,2,2)
[B,L] = bwboundaries(img,4);
imshow(img);
title('4-connected');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end


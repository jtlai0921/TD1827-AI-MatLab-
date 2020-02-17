%bwboundaries函數呼叫用法範例
%傳回物件數目和鄰域矩陣的呼叫格式
%清除螢幕
clc;
%清楚暫存的MATLAB空間變數
clear all;
%圖形讀取
img = imread('2.jpg');
%二值化，初步分析圖形要表達的內容
img=im2bw(img);
%%開始繪圖
figure,
subplot(1,2,1),
imshow(img); 
title('binaryzation');
 [B,L,N,A] = bwboundaries(img);
%預設使用8連通進行圖形邊界顯示
subplot(1,2,2),
imshow(img); title('add boundaries');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end

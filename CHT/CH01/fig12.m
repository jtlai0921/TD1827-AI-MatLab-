close all; 
clear all;
%讀取圖形
I=im2bw(imread('1.jpg')); 
%填洞
I1 = ~I;
I2 = imfill(I1,'holes');
%膨脹
SE = ones(3); 
I3 = imdilate(I2,SE,'same'); 
%用canny算子進行邊緣檢驗
BW1=edge(I3,'canny'); 
%顯示圖形;
%1行2列合並顯示
figure; 
subplot(1,2,1),
%第一列為原始圖形
imshow(I);
title('original image'); 
%第二列為邊緣檢驗結果
subplot(1,2,2),
imshow(BW1);title('canny result');

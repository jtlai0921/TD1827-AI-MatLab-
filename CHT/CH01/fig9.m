close all; 
clear all;
%讀取圖形
I=im2bw(imread('1.jpg')); 
%用prewitt算子進行邊緣檢驗
BW1=edge(I,'roberts'); 
%顯示圖形：
figure; 
%1行2列合並顯示
%第一列為原始圖形
subplot(1,2,1), 
imshow(I);
title('original image');
%第二列為邊緣檢驗結果
subplot(1,2,2), 
imshow(BW1);
title('prewitt result'); 

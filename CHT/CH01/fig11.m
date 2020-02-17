close all; clear all;
I=im2bw(imread('1.jpg')); %讀取圖形
BW1=edge(I,'canny'); %用canny算子進行邊緣檢驗
figure; %顯示圖形;1行2列合並顯示
subplot(1,2,1),imshow(I);title('original image'); %第一列為原始圖形
subplot(1,2,2),imshow(BW1);title('canny result'); %第二列為邊緣檢驗結果

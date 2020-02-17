close all;clear all;
I=im2bw(imread('1.jpg')); BW1=edge(I,'sobel'); %用SOBEL算子進行邊緣檢驗
figure; %顯示圖形：
subplot(1,2,1), imshow(I);title('original image');
subplot(1,2,2), imshow(BW1);title('sobel result'); 

clc; 
clear all;
img1 = imread('1.jpg');
img2 = imread('2.jpg');
figure, 
subplot(2,2,1),imshow(img1);
img1 = im2bw(img1);
%（圖形分割）轉化為二值圖
img1 = not(img1);
%把圖形想表達的內容變成1
subplot(2,2,2), imshow(img1);
subplot(2,2,3), imshow(img2);
img2 = im2bw(img2);
%（圖形分割）轉化為二值圖
img2 = not(img2);
%把圖形想表達的內容變成1
subplot(2,2,4), imshow(img2);

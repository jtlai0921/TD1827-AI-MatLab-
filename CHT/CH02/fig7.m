clc; clear all;
img = imread('2.jpg'); img=im2bw(img);
%二值化，初步分析圖形要表達的內容
figure,
subplot(2,2,1),
BW = bwareaopen(img,1,8);
imshow(BW);title('P=1');
subplot(2,2,2),
BW = bwareaopen(img,10,8);
imshow(BW);title('P=10');
subplot(2,2,3),
BW = bwareaopen(img,100,8);
imshow(BW);title('P=100');
subplot(2,2,4),
BW = bwareaopen(img,1000,8);
imshow(BW);title('P=1000');
%依次移除二值圖形BW中面積小於P=1,10,100,1000的物件，預設情況下使用8鄰域 

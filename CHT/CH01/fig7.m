close all;clear all;
I=im2bw(imread('1.jpg')); BW1=edge(I,'sobel'); %��SOBEL��l�i����t����
figure; %��ܹϧΡG
subplot(1,2,1), imshow(I);title('original image');
subplot(1,2,2), imshow(BW1);title('sobel result'); 

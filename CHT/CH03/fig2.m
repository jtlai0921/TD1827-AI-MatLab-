clc;clear all;close all;
x=rgb2gray(imread('1.jpg'));
figure,
m=3;n=2;
subplot(2,2,1);y = downsample(x,m);imshow(y);title('downsample(x,3)');        
subplot(2,2,2);y = downsample(x,m,n);
imshow(y);title('downsample(x,3,2)');
m=4;n=2;
subplot(2,2,3);y = downsample(x,m);imshow(y);title('downsample(x,4)');         
subplot(2,2,4);y = downsample(x,m,n);imshow(y);
title('downsample(x,4,2)');

close all; 
clear all;
%Ū���ϧ�
I=im2bw(imread('1.jpg')); 
%��}
I1 = ~I;
I2 = imfill(I1,'holes');
%����
SE = ones(3); 
I3 = imdilate(I2,SE,'same'); 
%��canny��l�i����t����
BW1=edge(I3,'canny'); 
%��ܹϧ�;
%1��2�C�X�����
figure; 
subplot(1,2,1),
%�Ĥ@�C����l�ϧ�
imshow(I);
title('original image'); 
%�ĤG�C����t���絲�G
subplot(1,2,2),
imshow(BW1);title('canny result');

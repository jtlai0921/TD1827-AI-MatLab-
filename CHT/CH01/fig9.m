close all; 
clear all;
%Ū���ϧ�
I=im2bw(imread('1.jpg')); 
%��prewitt��l�i����t����
BW1=edge(I,'roberts'); 
%��ܹϧΡG
figure; 
%1��2�C�X�����
%�Ĥ@�C����l�ϧ�
subplot(1,2,1), 
imshow(I);
title('original image');
%�ĤG�C����t���絲�G
subplot(1,2,2), 
imshow(BW1);
title('prewitt result'); 

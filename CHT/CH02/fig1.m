clc; 
clear all;
img1 = imread('1.jpg');
img2 = imread('2.jpg');
figure, 
subplot(2,2,1),imshow(img1);
img1 = im2bw(img1);
%�]�ϧΤ��Ρ^��Ƭ��G�ȹ�
img1 = not(img1);
%��ϧηQ��F�����e�ܦ�1
subplot(2,2,2), imshow(img1);
subplot(2,2,3), imshow(img2);
img2 = im2bw(img2);
%�]�ϧΤ��Ρ^��Ƭ��G�ȹ�
img2 = not(img2);
%��ϧηQ��F�����e�ܦ�1
subplot(2,2,4), imshow(img2);

clc;
clear all;
close all;
I = imread('1.jpg');
I=im2bw(I);
fun = @(x)im2bw(x,graythresh(x));
I2 = blkproc(I,[16 16],fun);
subplot(1,2,1);
imshow(I), 
title('original face');%��ܭ�l�H�y�ϧ�
subplot(1,2,2);
imshow(I2,'DisplayRange',[])
title('blocked:16*16');% ���q���]�w��

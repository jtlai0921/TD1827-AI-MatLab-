clc;
clear all;
close all;
I = imread('1.jpg');
subplot(121)
imshow(I);
title('original')

J =imresize(I,2);%使用預設的最近鄰插值法將圖形拉近兩倍
subplot(122)
imshow(J);
title('imresize')

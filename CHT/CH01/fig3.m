close all; 
clear; clc;
BW1 = im2bw(imread('1.jpg'));
BW2 = imfill(BW1,'holes');
subplot(121), 
imshow(BW1), 
title('im2bw result')
subplot(122), 
imshow(BW2), 
title('imfill result')

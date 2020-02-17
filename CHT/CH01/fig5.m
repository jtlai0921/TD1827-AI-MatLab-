close all; clear; clc;
BW1 = im2bw(imread('1.jpg')); I = imread('1.jpg');
IBW = ~BW1;F1 = imfill(IBW,'holes');SE = ones(3);%¶ñ¬}
F2 = imdilate(F1,SE,'same');BW3 = bwperim(F2); %¿±µÈ«á¤ÀªR½ü¹ø
subplot(1,2,1);imshow(I);title('original image');
subplot(1,2,2), imshow(BW3);title('bwperim result');

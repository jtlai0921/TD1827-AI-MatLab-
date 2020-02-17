clc; 
clear all;
IM = imread('3.jpg');
IM1 = imclearborder(IM,4);
BW=im2bw(IM); 
IM2 = imclearborder(BW,4);
figure
subplot(2,2,1),
imshow(IM);title('original');
subplot(2,2,2),
imshow(BW);title('binary');
subplot(2,2,3),
imshow(IM1);title('original+imclearborder');
subplot(2,2,4),
imshow(IM2);title('binary+imclearborder');

clc; 
clear all;
IM = imread('2.jpg');BW=im2bw(IM); 
BW1 = imregionalmin(BW,8);
BW2 = imregionalmax(BW,8);
figure
subplot(1,2,1),
imshow(BW1);title('imregionalmin');
subplot(1,2,2),
imshow(BW2);title('imregionalmax');

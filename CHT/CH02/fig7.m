clc; clear all;
img = imread('2.jpg'); img=im2bw(img);
%�G�ȤơA��B���R�ϧέn��F�����e
figure,
subplot(2,2,1),
BW = bwareaopen(img,1,8);
imshow(BW);title('P=1');
subplot(2,2,2),
BW = bwareaopen(img,10,8);
imshow(BW);title('P=10');
subplot(2,2,3),
BW = bwareaopen(img,100,8);
imshow(BW);title('P=100');
subplot(2,2,4),
BW = bwareaopen(img,1000,8);
imshow(BW);title('P=1000');
%�̦������G�ȹϧ�BW�����n�p��P=1,10,100,1000������A�w�]���p�U�ϥ�8�F�� 

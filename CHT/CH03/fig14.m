clc;
clear all;
close all;
I = imread('1.jpg');
subplot(121)
imshow(I);
title('original')

J =imresize(I,2);%�ϥιw�]���̪�F���Ȫk�N�ϧΩԪ�⭿
subplot(122)
imshow(J);
title('imresize')

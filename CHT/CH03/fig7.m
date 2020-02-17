clc;
clear all;
close all;

subplot(2,2,1);
I1=imread('2.jpg');%Ū���H�y�ϧ�
imshow(I1);
title('original face');%��ܭ�l�H�y�ϧ�

subplot(2,2,2);
I2=im2bw(I1,0.5);   %�N�H�y�ϧΤG�ȤơA�]�w��=0.5  
imshow(I2);
title('binary face'); %��ܤG�Ȥƪ��H�y�ϧ�

subplot(2,2,3);
%�}�l��H�y�ϧζi���ܴ��ѽX�A���������E���ܴ� 
I3=im2double(I1);
D=dctmtx(8);
B=blkproc(I2,[8,8],'P1*x*P2',D,D');
mask=[1 1 1 1 1 1 1 1;1 1 1 1 0 0 0 0;...
1 1 0 0 0 0 1 1;1 0 0 0 1 1 1 0;...
1 0 0 1 1 0 0 1;1 0 1 1 0 0 1 0;...
1 0 1 0 0 1 0 1;1 0 1 0 1 0 1 0];
B2=blkproc(B,[8,8],'P1.*x',mask);
I3=blkproc(B2,[8,8],'P1*x*P2',D',D);%�H�y�ϧθѽX����
imshow(I3);
title('DCT coding');

subplot(2,2,4);
%�}�l��H�y�ϧζi���ܴ��ѽX�A���ΤG���p�i�ܴ� 
I4=double(I2)/255;

[C,S]=wavedec2(I4,2,'bior3.7');  
%��H�y�ϧΥ�bior3.7�p�i���h�p�i����

ca1=appcoef2(C,S,'bior3.7',1); 
%�O�d�p�i���ѲĢ��h�C�W�T���A�i��ϧ����Y

ca1=wcodemat(ca1,440,'mat',0); 
%��Ģ��h�T���i��q�ƸѽX

%�ܦ��H�y�ϧθѽX�����I

imagesc(ca1);
colormap(gray);
%��ܲĤ@�h�]50�H�ѪR�ס^���ϧ�
title('wavedec2 coding')

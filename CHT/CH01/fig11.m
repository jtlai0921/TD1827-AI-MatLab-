close all; clear all;
I=im2bw(imread('1.jpg')); %Ū���ϧ�
BW1=edge(I,'canny'); %��canny��l�i����t����
figure; %��ܹϧ�;1��2�C�X�����
subplot(1,2,1),imshow(I);title('original image'); %�Ĥ@�C����l�ϧ�
subplot(1,2,2),imshow(BW1);title('canny result'); %�ĤG�C����t���絲�G

%bwboundaries��ƩI�s�Ϊk�d��
%�Ǧ^����ƥةM�F��x�}���I�s�榡
%�M���ù�
clc;
%�M���Ȧs��MATLAB�Ŷ��ܼ�
clear all;
%�ϧ�Ū��
img = imread('2.jpg');
%�G�ȤơA��B���R�ϧέn��F�����e
img=im2bw(img);
%%�}�lø��
figure,
subplot(1,2,1),
imshow(img); 
title('binaryzation');
 [B,L,N,A] = bwboundaries(img);
%�w�]�ϥ�8�s�q�i��ϧ�������
subplot(1,2,2),
imshow(img); title('add boundaries');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end

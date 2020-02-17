%bwboundaries��ƩI�s�Ϊk�d��
%���w�ϥγs�q�ʪ��I�s�榡
% 8�s�q�P4�s�q�����
clc;
%�M���Ȧs��MATLAB�Ŷ��ܼ�
clear all;
%%�ϧ�Ū���ΤG�Ȥ�
img = imread('2.jpg');
img=im2bw(img);

%%�}�lø��
figure,
%%��ø��ϥ�8�s�q�i��ϧ������ܪ����G
subplot(1,2,1)
[B,L] = bwboundaries(img,8);
%���w�ϥ�8�s�q�i��ϧ�������
imshow(img);
title('8-connected');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end
%�Aø��ϥ�4�s�q�i��ϧ������ܪ����G
subplot(1,2,2)
[B,L] = bwboundaries(img,4);
imshow(img);
title('4-connected');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end


clc;
clear all;
img = imread('2.jpg');
img=im2bw(img);
[B,L] = bwboundaries(img);
figure,
imshow(img);
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end
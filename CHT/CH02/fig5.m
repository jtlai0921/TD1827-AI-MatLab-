%bwboundaries��ƩI�s�Ϊk�d�ҡA���ѿ���r���J���I�s�榡
%���ܤհϰ�P�����ܤհϰ쪺����A�]conn�i�H�]�w��8��4�A�@4�ӵ��G��
clc;
%�M���Ȧs��MATLAB�Ŷ��ܼ�
clear all;
%%�ϧ�Ū���ΤG�Ȥ�
img = imread('2.jpg');
img=im2bw(img);
%%�}�lø��
figure,
%%��ø����ܤհϰ�A�ϥ�8�s�q�i��ϧ������ܪ����G
subplot(2,2,1)
[B,L] = bwboundaries(img,8);
%���w�ϥ�8�s�q�i��ϧ�������
imshow(img);
title('8-connected, with holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end
%%�Aø����ܤհϰ�A�ϥ�8�s�q�i��ϧ������ܪ����G
subplot(2,2,2)
[B,L] = bwboundaries(img,8,'noholes');
imshow(img);
title('8-connected, no holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end
%%����ø����ܤհϰ�A��4�s�q�i��ϧ������ܪ����G
subplot(2,2,3)
[B,L] = bwboundaries(img,4);
%���w�ϥ�8�s�q�i��ϧ�������
imshow(img);
title('4-connected,with holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end
%�̫�ø����ܤհϰ�A�ϥ�4�s�q�i��ϧ������ܪ����G
subplot(2,2,4)
[B,L] = bwboundaries(img,4,'noholes');
imshow(img);
title('4-connected, no holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'y','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F���Ŧ�ХܡA�H��X�ϧ������ܵ��G�F 
end


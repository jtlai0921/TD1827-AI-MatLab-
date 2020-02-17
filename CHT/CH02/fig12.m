clc; 
clear all;
IM = imread('3.jpg'); P = rgb2gray(IM); L = bwlabel(P);
rec = regionprops(L,'BoundingBox');
%�ΰϰ��ݩʫ׶q��Ƨ�X�]�A�����ϰ쪺�̤p�x��
figure,
subplot(1,2,1), imshow(IM); title('original');
subplot(1,2,2), imshow(IM), title('marked');
rectangle('Position',rec(1).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','--','EdgeColor','r'); 

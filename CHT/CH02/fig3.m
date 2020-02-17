clc;
clear all;
img = imread('2.jpg');
figure,
subplot(2,2,1),
imshow(img); 
title('original');
img=im2bw(img);
img1=edge(img,'sobel'); 
%��SOBEL��l�i����t����
subplot(2,2,2),
imshow(img1); 
title('edge');
img2 = bwperim(img,8); 
%��bwperim��ƶi��������R
subplot(2,2,3),
imshow(img2); 
title('bwperim');
subplot(2,2,4),
 [B,L] = bwboundaries(img);
imshow(img);
hold on;
for k = 1:length(B)
    boundary = B{k};
%�@�Ӥ@�Ӥ��R��ɹ���
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%�@�Ӥ@�ӼХ���ɹ����F�ά���ХܡA�H��X�ϧ������ܵ��G�F 
end
title('bwboundaries');

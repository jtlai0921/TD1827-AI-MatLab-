%���T�ӯS���I���H�y���
%���{���X�Ω���R�H�y�ϧΪ��S���I�y��
clc; 
clear all;
IM = imread('1.jpg');
imshow(IM);%�o�̵L���ন�G�ȹ�
hold on;
NUM=3; 
%�S���I�ӼƬ�3 
landmark=[];
for k=1:NUM
a=ginput(1);
plot(a(1),a(2),'b.','MarkerSize',10,'LineWidth',2);
landmark=[landmark;a];
end
%�o��S���I�y��
hold off;

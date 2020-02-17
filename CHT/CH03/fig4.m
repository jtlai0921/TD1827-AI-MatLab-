clc;
clear all;
close all;
I=imread('1.jpg');%Ū���H�y�ϧ�
s=2;%�Y�񭿼ơA�Y���P��l�j�p�����
figure,
subplot(1,2,1);imshow(I);title('original');%��l�H�y�ϧΪ��i��

subplot(1,2,2);
[m n d]=size(I);%���o�H�y�ϧΤؤo�T��
%%�U���}�l����
if s<=1 & s>0
    for i=1:d
        I1(:,:,i)=I(round(1:1/s:m),round(1:1/s:n),i);
    end
elseif s>1
    [X Y]=meshgrid(1:n,1:m);
    [Xt Yt]=meshgrid(1:1/s:n,1:1/s:m);%��meshgrid ��ƥΨӲ��ͺ���x�}
    for i=1:d
        I1(:,:,i)=interp2(double(I(:,:,i)),Xt,Yt,'spline'); 
%��interp2��ƹ�H�y�ϧζi�洡��
    end
    if isa(I,'uint8')
        I1=uint8(I1);
    else 
        I1=uint16(I1);
    end
end %���ȧ���
imshow(I1);
title('interp2');

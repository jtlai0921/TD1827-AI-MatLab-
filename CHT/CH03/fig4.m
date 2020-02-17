clc;
clear all;
close all;
I=imread('1.jpg');%讀取人臉圖形
s=2;%縮放倍數，縮放後與原始大小的比值
figure,
subplot(1,2,1);imshow(I);title('original');%原始人臉圖形的展示

subplot(1,2,2);
[m n d]=size(I);%取得人臉圖形尺寸訊息
%%下面開始插值
if s<=1 & s>0
    for i=1:d
        I1(:,:,i)=I(round(1:1/s:m),round(1:1/s:n),i);
    end
elseif s>1
    [X Y]=meshgrid(1:n,1:m);
    [Xt Yt]=meshgrid(1:1/s:n,1:1/s:m);%用meshgrid 函數用來產生網格矩陣
    for i=1:d
        I1(:,:,i)=interp2(double(I(:,:,i)),Xt,Yt,'spline'); 
%用interp2函數對人臉圖形進行插值
    end
    if isa(I,'uint8')
        I1=uint8(I1);
    else 
        I1=uint16(I1);
    end
end %插值完成
imshow(I1);
title('interp2');

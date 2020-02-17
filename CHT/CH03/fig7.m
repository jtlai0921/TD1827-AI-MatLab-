clc;
clear all;
close all;

subplot(2,2,1);
I1=imread('2.jpg');%讀取人臉圖形
imshow(I1);
title('original face');%顯示原始人臉圖形

subplot(2,2,2);
I2=im2bw(I1,0.5);   %將人臉圖形二值化，設定值=0.5  
imshow(I2);
title('binary face'); %顯示二值化的人臉圖形

subplot(2,2,3);
%開始對人臉圖形進行變換解碼，采用離散余弦變換 
I3=im2double(I1);
D=dctmtx(8);
B=blkproc(I2,[8,8],'P1*x*P2',D,D');
mask=[1 1 1 1 1 1 1 1;1 1 1 1 0 0 0 0;...
1 1 0 0 0 0 1 1;1 0 0 0 1 1 1 0;...
1 0 0 1 1 0 0 1;1 0 1 1 0 0 1 0;...
1 0 1 0 0 1 0 1;1 0 1 0 1 0 1 0];
B2=blkproc(B,[8,8],'P1.*x',mask);
I3=blkproc(B2,[8,8],'P1*x*P2',D',D);%人臉圖形解碼結束
imshow(I3);
title('DCT coding');

subplot(2,2,4);
%開始對人臉圖形進行變換解碼，采用二維小波變換 
I4=double(I2)/255;

[C,S]=wavedec2(I4,2,'bior3.7');  
%對人臉圖形用bior3.7小波２層小波分解

ca1=appcoef2(C,S,'bior3.7',1); 
%保留小波分解第１層低頻訊息，進行圖形壓縮

ca1=wcodemat(ca1,440,'mat',0); 
%對第１層訊息進行量化解碼

%至此人臉圖形解碼結束！

imagesc(ca1);
colormap(gray);
%顯示第一層（50％解析度）的圖形
title('wavedec2 coding')

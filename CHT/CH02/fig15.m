%基於三個特征點的人臉對齊
%此程式碼用於分析人臉圖形的特征點座標
clc; 
clear all;
IM = imread('1.jpg');
imshow(IM);%這裡無需轉成二值圖
hold on;
NUM=3; 
%特征點個數為3 
landmark=[];
for k=1:NUM
a=ginput(1);
plot(a(1),a(2),'b.','MarkerSize',10,'LineWidth',2);
landmark=[landmark;a];
end
%得到特征點座標
hold off;

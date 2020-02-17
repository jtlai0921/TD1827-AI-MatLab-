%bwboundaries函數呼叫用法範例，提供選取字串輸入的呼叫格式
%跟蹤孔區域與不跟蹤孔區域的比較，因conn可以設定為8或4，共4個結果圖
clc;
%清楚暫存的MATLAB空間變數
clear all;
%%圖形讀取及二值化
img = imread('2.jpg');
img=im2bw(img);
%%開始繪圖
figure,
%%先繪制跟蹤孔區域，使用8連通進行圖形邊界顯示的結果
subplot(2,2,1)
[B,L] = bwboundaries(img,8);
%指定使用8連通進行圖形邊界顯示
imshow(img);
title('8-connected, with holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end
%%再繪制不跟蹤孔區域，使用8連通進行圖形邊界顯示的結果
subplot(2,2,2)
[B,L] = bwboundaries(img,8,'noholes');
imshow(img);
title('8-connected, no holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end
%%接著繪制跟蹤孔區域，用4連通進行圖形邊界顯示的結果
subplot(2,2,3)
[B,L] = bwboundaries(img,4);
%指定使用8連通進行圖形邊界顯示
imshow(img);
title('4-connected,with holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end
%最後繪制不跟蹤孔區域，使用4連通進行圖形邊界顯示的結果
subplot(2,2,4)
[B,L] = bwboundaries(img,4,'noholes');
imshow(img);
title('4-connected, no holes');
hold on;
for k = 1:length(B)
    boundary = B{k};
%一個一個分析邊界像素
    plot(boundary(:,2),boundary(:,1),'y','LineWidth',2);
%一個一個標示邊界像素；用藍色標示，以突出圖形邊界顯示結果； 
end


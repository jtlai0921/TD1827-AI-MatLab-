%關閉正在執行的MATLAB程式及圖形
close all; 
%清除空間變數訊息，內含給予值訊息
clear; 
%清除螢幕
clc;
BW = im2bw(imread('1.jpg')); %讀取二值圖
%畫圖；原圖與19種形態學處理結果合並顯示
subplot(4,5,1), 
imshow(BW); title('original');
subplot(4,5,2), 
BW2 = bwmorph(BW,'bridge');
imshow(BW2); title('brige');
subplot(4,5,3), 
BW3 = bwmorph(BW,'clean');
imshow(BW3); title('clean');
subplot(4,5,4), 
BW4 = bwmorph(BW,'close');
imshow(BW4); title('close');
subplot(4,5,5), 
BW5 = bwmorph(BW,'diag');
imshow(BW5); title('diag');
subplot(4,5,6), 
BW6 = bwmorph(BW,'dilate');
imshow(BW6); title('dilate');
subplot(4,5,7), 
BW7 = bwmorph(BW,'endpoints');
imshow(BW7); title('endpoints');
subplot(4,5,8), 
BW8 = bwmorph(BW,'erode');
imshow(BW8); title('erode');
subplot(4,5,9), 
BW9 = bwmorph(BW,'branchpoints');
imshow(BW9); title('branchpoints');
subplot(4,5,10),
BW10 = bwmorph(BW,'bothat');
imshow(BW10); title('bothat');
subplot(4,5,11),
BW11 = bwmorph(BW,'fill');
imshow(BW11); title('fill');
subplot(4,5,12),
BW12 = bwmorph(BW,'majority');
imshow(BW12); title('majority');
subplot(4,5,13),
BW13 = bwmorph(BW,'open');
imshow(BW13); title('open');
subplot(4,5,14),
BW14 = bwmorph(BW,'remove');
imshow(BW14); title('remove');
subplot(4,5,15),
BW15 = bwmorph(BW,'spur');
imshow(BW15); title('spur');
subplot(4,5,16),
BW16 = bwmorph(BW,'skel',Inf);
imshow(BW16); title('skel');
subplot(4,5,17),
BW17 = bwmorph(BW,'thicken',Inf);
imshow(BW17); title('thicken');
subplot(4,5,18),
BW18 = bwmorph(BW,'thin',Inf);
imshow(BW18); title('thin');
subplot(4,5,19),
BW19 = bwmorph(BW,'tophat');
imshow(BW19); title('tophat');
subplot(4,5,20),
BW19 = bwmorph(BW,'hbreak');
imshow(BW19); title('hbreak');
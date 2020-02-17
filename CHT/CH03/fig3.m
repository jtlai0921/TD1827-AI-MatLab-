clc;
clear all;
close all;
I = imread('./1.jpg'); 
% 讀入人臉圖形，儲存的是unit8型(0~255)資料
I1  = double(I); imshow(I1);    
% 把人臉圖形轉換成double精度型態（0~255）
I2  = im2double(I);    
% 把人臉圖形轉換成double精度型態（0~1）
I3  = I1/255;   
% 將uint8轉換成double後歸一化,相當於im2double
subplot(2,2,1);imshow(I1); 
title('double');
subplot(2,2,2);imshow(I2);
title('im2double');
subplot(2,2,3);imshow(I3);
title('double+歸一化');
subplot(2,2,4);imshow(I);
title('original');

clc;
clear all;
close all;
I = imread('./1.jpg'); 
% Ū�J�H�y�ϧΡA�x�s���Ounit8��(0~255)���
I1  = double(I); imshow(I1);    
% ��H�y�ϧ��ഫ��double��׫��A�]0~255�^
I2  = im2double(I);    
% ��H�y�ϧ��ഫ��double��׫��A�]0~1�^
I3  = I1/255;   
% �Nuint8�ഫ��double���k�@��,�۷��im2double
subplot(2,2,1);imshow(I1); 
title('double');
subplot(2,2,2);imshow(I2);
title('im2double');
subplot(2,2,3);imshow(I3);
title('double+�k�@��');
subplot(2,2,4);imshow(I);
title('original');

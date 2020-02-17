clc;
clear all;
close all;
I = imread('1.jpg');
I=im2bw(I);
fun = @(x) std2(x)*ones(size(x)); %定義fun;這裡x是要處理的矩陣
I2 = blkproc(I,[2 2],fun);
I3 = blkproc(I,[3 3],fun);
I4 = blkproc(I,[4 4],fun);
I5 = blkproc(I,[5 5],fun);
I6 = blkproc(I,[6 6],fun);
subplot(3,2,1);
imshow(I), 
title('original face');%顯示原始人臉圖形
subplot(3,2,2);
imshow(I2,'DisplayRange',[])
title('mosaics face:2*2');%顯示打馬賽克的人臉圖形
subplot(3,2,3);
imshow(I2,'DisplayRange',[])
title('mosaics face:3*3');%顯示打馬賽克的人臉圖形
subplot(3,2,4);
imshow(I2,'DisplayRange',[])
title('mosaics face:4*4');%顯示打馬賽克的人臉圖形
subplot(3,2,5);
imshow(I2,'DisplayRange',[])
title('mosaics face:5*5');%顯示打馬賽克的人臉圖形
subplot(3,2,6);
imshow(I2,'DisplayRange',[])
title('mosaics face:6*6');%顯示打馬賽克的人臉圖形

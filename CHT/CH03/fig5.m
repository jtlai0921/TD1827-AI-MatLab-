clc;
clear all;
close all;
I = imread('1.jpg');
I=im2bw(I);
fun = @(x) std2(x)*ones(size(x)); %�w�qfun;�o��x�O�n�B�z���x�}
I2 = blkproc(I,[2 2],fun);
I3 = blkproc(I,[3 3],fun);
I4 = blkproc(I,[4 4],fun);
I5 = blkproc(I,[5 5],fun);
I6 = blkproc(I,[6 6],fun);
subplot(3,2,1);
imshow(I), 
title('original face');%��ܭ�l�H�y�ϧ�
subplot(3,2,2);
imshow(I2,'DisplayRange',[])
title('mosaics face:2*2');%��ܥ����ɧJ���H�y�ϧ�
subplot(3,2,3);
imshow(I2,'DisplayRange',[])
title('mosaics face:3*3');%��ܥ����ɧJ���H�y�ϧ�
subplot(3,2,4);
imshow(I2,'DisplayRange',[])
title('mosaics face:4*4');%��ܥ����ɧJ���H�y�ϧ�
subplot(3,2,5);
imshow(I2,'DisplayRange',[])
title('mosaics face:5*5');%��ܥ����ɧJ���H�y�ϧ�
subplot(3,2,6);
imshow(I2,'DisplayRange',[])
title('mosaics face:6*6');%��ܥ����ɧJ���H�y�ϧ�

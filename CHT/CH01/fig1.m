I = imread('1.jpg');BW1=im2bw(I);%�G�Ȥ�
BW2 = bwperim(BW1,8);
imshow(BW1)
figure, imshow(BW2)
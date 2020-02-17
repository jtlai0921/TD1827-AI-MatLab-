I = imread('1.jpg');BW1=im2bw(I);%¤G­È¤Æ
BW2 = bwperim(BW1,8);
subplot(1,2,1);imshow(BW1);title('binary image');
subplot(1,2,2), imshow(BW2);title('bwperim result');

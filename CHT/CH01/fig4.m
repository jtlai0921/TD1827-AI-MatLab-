a= im2bw(imread('1.jpg')); %��J�G�ȹϧ� 
b=[0 1 0;1 1 1;0 1 0];  %�ѼƳ]�w
c=imdilate(a,b);%���Ȱʧ@
imshow(c)%��ܰ��浲�G

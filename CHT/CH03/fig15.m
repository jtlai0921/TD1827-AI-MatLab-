%Ū����J�ϧ�
I = '3.jpg'; %�]�i�H�b��Ʈw�����o�A��Ū�̹��աC
subplot(121),
imshow(I);
title('���')

%�ϧΨ��˫e���w���B�z
Tt_DAT = imread(I);
if ndims(Tt_DAT) == 3
    Tt_DAT = rgb2gray(Tt_DAT);
end
%�ϧιw���B�z�����C

%%�}�l�ϧΨ��ˡI

%���˼Ҧ��������ˡA�Ψ��imresize��{

%�]�w���˰Ѽ�
im_h       = 42*2;
im_w       = 30*2;

%%�ϧΨ��˹L�{�p�U�G
for i = 1:size(Tr_DAT,2)
    tem = reshape(Tr_DAT(:,i),[165 120]);
    tem1 = uint8(imresize(tem,[im_h im_w]));
    O_Tr_DAT(:,i) = tem1(:);
end

Tem_DAT = [];

for i = 1:1
    tem = Tt_DAT;
    tem1 = uint8(imresize(tem,[im_h im_w]));
    O_Tt_DAT(:,i) = tem1(:);
end
subplot(122),
imshow(Tt_DAT);
title('���˵��G')

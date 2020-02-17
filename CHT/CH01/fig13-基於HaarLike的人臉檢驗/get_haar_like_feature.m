function locs = get_haar_like_feature(imageFile)
% �P�_�Ѽ�
if nargin < 1
    % �w�]�Ѽ�
    imageFile = fullfile(pwd, 'images/lena.jpg');
end
% Ū���ϧ�
I = imread(imageFile);
% �Ƕ��B�z
if ndims(I) == 3
    I = im2double(rgb2gray(I));
else
    I = im2double(I);
end
% ���O�غc
command = '!HaarLike ';
command = sprintf('%s %s', command, imageFile);
% ����
eval(command);
% ���o���G���
loc = load('tmp.key');
% ��������
g1 = fspecial('gaussian', 7, 1);
gray_image = imfilter(I, g1);
% �p��k����
h = fspecial('sobel');
Ix = imfilter(gray_image,h,'replicate','same');
Iy = imfilter(gray_image,h','replicate','same');
% �ѼƲպA
sigma = 2;
thd = 0.05;
r = 2;
% �����o�i
g = fspecial('gaussian',fix(6*sigma), sigma);
Ix2 = imfilter(Ix.^2, g, 'same').*(sigma^2);
Iy2 = imfilter(Iy.^2, g, 'same').*(sigma^2);
Ixy = imfilter(Ix.*Iy, g, 'same').*(sigma^2);
% �p��haar�S����
R = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps);
d = 2*r+1;
% ���R�S���I
localmax = ordfilt2(R,d^2,true(d));
R = R.*(and(R==localmax, R>thd));
% �h���|�P���n�I
R([1:r, end-r:end], :) = 0;
R(:,[1:r,end-r:end]) = 0;
% ���R���įS���I
[xp,yp,~] = find(R);
% �x�s�öǦ^
locs{1} = loc;
locs{2} = [yp, xp];
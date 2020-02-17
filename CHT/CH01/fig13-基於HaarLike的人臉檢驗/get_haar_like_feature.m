function locs = get_haar_like_feature(imageFile)
% 判斷參數
if nargin < 1
    % 預設參數
    imageFile = fullfile(pwd, 'images/lena.jpg');
end
% 讀取圖形
I = imread(imageFile);
% 灰階處理
if ndims(I) == 3
    I = im2double(rgb2gray(I));
else
    I = im2double(I);
end
% 指令建構
command = '!HaarLike ';
command = sprintf('%s %s', command, imageFile);
% 執行
eval(command);
% 取得結果資料
loc = load('tmp.key');
% 高斯平順
g1 = fspecial('gaussian', 7, 1);
gray_image = imfilter(I, g1);
% 計算女提督
h = fspecial('sobel');
Ix = imfilter(gray_image,h,'replicate','same');
Iy = imfilter(gray_image,h','replicate','same');
% 參數組態
sigma = 2;
thd = 0.05;
r = 2;
% 高斯濾波
g = fspecial('gaussian',fix(6*sigma), sigma);
Ix2 = imfilter(Ix.^2, g, 'same').*(sigma^2);
Iy2 = imfilter(Iy.^2, g, 'same').*(sigma^2);
Ixy = imfilter(Ix.*Iy, g, 'same').*(sigma^2);
% 計算haar特征域
R = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps);
d = 2*r+1;
% 分析特征點
localmax = ordfilt2(R,d^2,true(d));
R = R.*(and(R==localmax, R>thd));
% 去除四周噪聲點
R([1:r, end-r:end], :) = 0;
R(:,[1:r,end-r:end]) = 0;
% 分析有效特征點
[xp,yp,~] = find(R);
% 儲存並傳回
locs{1} = loc;
locs{2} = [yp, xp];
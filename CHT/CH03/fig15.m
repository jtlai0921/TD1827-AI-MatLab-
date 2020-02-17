%讀取輸入圖形
I = '3.jpg'; %也可以在資料庫中取得，請讀者嘗試。
subplot(121),
imshow(I);
title('原圖')

%圖形取樣前的預先處理
Tt_DAT = imread(I);
if ndims(Tt_DAT) == 3
    Tt_DAT = rgb2gray(Tt_DAT);
end
%圖形預先處理結束。

%%開始圖形取樣！

%取樣模式為降取樣，用函數imresize實現

%設定取樣參數
im_h       = 42*2;
im_w       = 30*2;

%%圖形取樣過程如下：
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
title('取樣結果')

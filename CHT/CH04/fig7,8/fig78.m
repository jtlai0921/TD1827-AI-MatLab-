clc;
clear all;
close all;
videoFilePath = fullfile(pwd, 'video', 'wangyanbo.avi');
%指定video資料夾下的視訊wangyanbo.avi作為讀取物件
obj = VideoReader(videoFilePath);
%若果不僅想讀取視訊，還想要顯示和儲存每一框，那麼可以這樣實現：
numFrames = obj.NumberOfFrames;% 框的總數
for k = 1 : numFrames% 讀取資料
    frame = read(obj,k);
    imshow(frame);%顯示每一框
f=getframe(gcf);
    ImagesPath = 'D:\wybimages\'; 
%指定資料夾，請注意這個資料夾必須存在且最好是空資料夾！
%換言之，你需要在程式執行之前先建立好這個計劃用來儲存圖形的空資料夾
%當然，你也可以用mkdir函數在MATLAB程式碼裡建立這個資料夾，下文介紹此函數。
imwrite(f.cdata,[ImagesPath,strcat(num2str(k),'.jpg')]);
% 儲存每一框到特殊的資料夾
end
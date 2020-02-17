clc; clear all; close all;
% 目的圖形大小
rows = 200;
cols = 200;
% 目的圖形
targetimage = zeros(rows,cols);
% 用於定義特征點位置的系數
rowFrac = 0.35;
colFrac = 0.65;
% 基於三點的特征點座標
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
mouth = [0.5*cols,rows*(1-rowFrac),];
landmark_tool = [le; re; mouth];
% 讀取檔案
Fname=fullfile(pwd, 'images', 'wwf.jpg');
inputimage=imread(Fname);%讀入圖形
figure;
imshow(inputimage);
hold on;
landmark=[];
% 特征點個數
TOLNUM=3;
for k=1:TOLNUM
    % 取點
    a=ginput(1);
    % 繪制
    plot(a(1),a(2),'r+');
    % 儲存
    landmark=[landmark;a];
end
hold off;
% 得到仿射變換
tform1 = cp2tform(landmark_tool,landmark,'affine');
% 得到目的圖形
result1 = imtransform(inputimage,tform1);

% 得到仿射變換
tform2 = fitgeotrans(landmark,landmark_tool,'affine');
% 得到目的圖形
result2 = imwarp(inputimage,tform2,'outputview',imref2d(size(targetimage)));

% 得到仿射變換
tform3 = estimateGeometricTransform(landmark,landmark_tool,'affine');
% 得到目的圖形
result3 = imwarp(inputimage,tform3,'outputview',imref2d(size(targetimage)));

% 顯示
figure;
imshow(result1);
figure;
imshow(result2);
figure;
imshow(result3);
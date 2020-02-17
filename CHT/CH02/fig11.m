clc; clear all;
IM = imread('3.jpg'); bw = rgb2gray(IM); L = bwlabel(bw);
Area = regionprops(L,'Area');
% 計算出在圖形各個區域中像素總個數
BoundingBox = regionprops(L,'BoundingBox');
% 包括對應區域的最小矩形
Centroid = regionprops(L,'Centroid');
% 每個區域的質心（重心）
MajorAxisLength = regionprops(L,'MajorAxisLength');
% 與區域具有相同標准二階中心矩的橢圓的長軸長度（像素意義下）；類別似的度量資料還有MinorAxisLength，與MajorAxisLength的用法也是類別似的.
Eccentricity = regionprops(L,'Eccentricity');
% 與區域具有相同標准二階中心矩的橢圓的離心率（可作為特征）
Orientation = regionprops(L,'Eccentricity');
% 與區域具有相同標准二階中心矩的橢圓的長軸與x軸的交角（度）
Image = regionprops(L,'Image');
% 與某區域具有相同大小的邏輯矩陣
FilledImage = regionprops(L,'FilledImage');
% 與某區域有相同大小的填充邏輯矩陣
FilledArea = regionprops(L,'FilledArea');
% 填充區域圖形中的on像素個數
ConvexHull = regionprops(L,'ConvexHull');
% 包括某區域的最小凸多邊形
ConvexImage = regionprops(L,'ConvexImage');
% 畫出上述區域最小凸多邊形
ConvexArea = regionprops(L,'ConvexArea');
% 填充區域凸多邊形圖形中的on像素個數
EulerNumber = regionprops(L,'EulerNumber');
% 幾何拓撲不變數——歐拉數
Extrema = regionprops(L,'EulerNumber');
% 八方向區域極值點
EquivDiameter = regionprops(L,'EquivDiameter');
% 與區域具有相同面積的圓的直徑
Solidity = regionprops(L,'Solidity');
% 同時在區域和其最小凸多邊形中的像素比例
Extent = regionprops(L,'Extent');
% 同時在區域和其最小邊界矩形中的像素比例
PixelIdxList = regionprops(L,'PixelIdxList');
% 儲存區域像素的索引索引
PixelList = regionprops(L,'PixelIdxList');
% 儲存上述索引對應的像素座標

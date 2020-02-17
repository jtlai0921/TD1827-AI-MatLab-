clc; clear all; close all;
% 選取圖形
imageFile = fullfile(pwd, 'images', '1.jpg');
image_origin = imread(imageFile);
% haar_like算子
loc = get_haar_like_feature(imageFile);
% 顯示關鍵點
disp_haar_like_feature(image_origin, loc);
clc; clear all; close all;
% ����ϧ�
imageFile = fullfile(pwd, 'images', '1.jpg');
image_origin = imread(imageFile);
% haar_like��l
loc = get_haar_like_feature(imageFile);
% ��������I
disp_haar_like_feature(image_origin, loc);
function [result_image1, result_image2] = Main_Process(input_file)
if nargin < 1
    % 預設參數
    clc;
    input_file = fullfile(pwd, 'test', 'Test1.jpg');
end
% RRC L1重構
[origin_image1, result_image1] = Reconstruct_L1(input_file);
% RRC L2重構
[origin_image2, result_image2] = Reconstruct_L2(input_file);
if nargin < 1
    % 顯示
    figure;
    subplot(2, 2, 1); imshow(origin_image1, []); title('原圖形');
    subplot(2, 2, 2); imshow(result_image1, []); title('RRC L1重構結果');
    subplot(2, 2, 3); imshow(origin_image2, []); title('原圖形');
    subplot(2, 2, 4); imshow(result_image2, []); title('RRC L2重構結果');
end


function [ro_data, rt_data, ru_label] = Data_PreProcess(r_data, r_label, input_file)
% 取得目前分類別數
class_num = max(r_label(:));
% 整合資料
ru_data = [];
ru_label = [];
for i = 1 : class_num
    ru_data = [ru_data r_data(:,1+7*(i-1)) r_data(:,5+7*(i-1):7+7*(i-1))];
    ru_label = [ru_label repmat(i,[1 4])];
end
% 讀取輸入圖形
tu_data = imread(input_file);
if ndims(tu_data) == 3
    tu_data = rgb2gray(tu_data);
end
% 降取樣參數
im_h = 84;
im_w = 60;
% 降取樣圖形資料
ro_data = [];
for i = 1:size(ru_data,2)
    % 分析樣本
    tmp = reshape(ru_data(:,i),[165 120]);
    % 降取樣
    tmp = uint8(imresize(tmp, [im_h im_w]));
    % 儲存
    ro_data(:,i) = tmp(:);
end
rt_data = [];
for i = 1:1
    % 分析樣本
    tmp = tu_data;
    % 降取樣
    tmp = uint8(imresize(tmp,[im_h im_w]));
    % 儲存
    rt_data(:,i) = tmp(:);
end
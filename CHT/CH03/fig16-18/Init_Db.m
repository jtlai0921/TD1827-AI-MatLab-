function [r_data, r_label] = Init_Db()
% 分類別數
class_num = 100;
% 每一類別的樣本數
class_sample = 7;
% 讀取資料庫
load(fullfile(pwd, 'database', 'face_db.mat'));
% 自訂資料夾
folder_add = fullfile(pwd, 'database', 'face_add');
folder_adds = dir(folder_add);
for i = 1 : length(folder_adds)
    if folder_adds(i).isdir == 1 && ~isequal(folder_adds(i).name, '.') && ~isequal(folder_adds(i).name, '..')
        % 讀取資料夾
        folder_add_j = fullfile(folder_add, folder_adds(i).name);
        % 取得目前標簽
        class_num = max(r_label(:));
        for j = 1 : class_sample
            % 讀取人臉圖形
            Ij = imread(fullfile(folder_add_j, sprintf('%02d.jpg', j)));
            if ndims(Ij) == 3
                % 灰階化
                Ij = rgb2gray(Ij);
            end
            % 增加到資料庫
            r_data(:, end+1) = Ij(:);
            r_label(:, end+1) = class_num+1;
        end
    end
end
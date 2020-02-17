function [r_data, r_label] = Init_Db()
% �����O��
class_num = 100;
% �C�@���O���˥���
class_sample = 7;
% Ū����Ʈw
load(fullfile(pwd, 'database', 'face_db.mat'));
% �ۭq��Ƨ�
folder_add = fullfile(pwd, 'database', 'face_add');
folder_adds = dir(folder_add);
for i = 1 : length(folder_adds)
    if folder_adds(i).isdir == 1 && ~isequal(folder_adds(i).name, '.') && ~isequal(folder_adds(i).name, '..')
        % Ū����Ƨ�
        folder_add_j = fullfile(folder_add, folder_adds(i).name);
        % ���o�ثe��ñ
        class_num = max(r_label(:));
        for j = 1 : class_sample
            % Ū���H�y�ϧ�
            Ij = imread(fullfile(folder_add_j, sprintf('%02d.jpg', j)));
            if ndims(Ij) == 3
                % �Ƕ���
                Ij = rgb2gray(Ij);
            end
            % �W�[���Ʈw
            r_data(:, end+1) = Ij(:);
            r_label(:, end+1) = class_num+1;
        end
    end
end
%%設定路徑
tem_facedata = cd;
par.d_facedata          =   [cd '/database/'];
addpath([cd '/RUNTIME/']);

%%設定參數
classnum        =   100;   %樣本數
par.nSample       =   7;   %同一樣本取樣數
par.ID            =   [];
par.nameDatabase  =   'AR_disguise';

%%載入人臉資料集
load([par.d_facedata 'AR_database']);
% 自訂資料夾，用於加入自己的人臉資料
folder_add = fullfile(pwd, 'database', 'face_add');
folder_adds = dir(folder_add);
for i = 1 : length(folder_adds)
    if folder_adds(i).isdir == 1 && ~isequal(folder_adds(i).name, '.') && ~isequal(folder_adds(i).name, '..')
%讀者請據此行程式碼進一步瞭解isequal函數用法
        
% 開始讀取自訂資料夾，加入新資料到AR_database
        folder_add_j = fullfile(folder_add, folder_adds(i).name);
        % 取得目前標簽
        classnum        =   max(Tr_sampleLabels(:));
%請讀者重點瞭解一下這裡為什麼能這樣取得目前標簽
        for j = 1 : 7
            % 讀取人臉圖形
            Ij = imread(fullfile(folder_add_j, sprintf('%02d.jpg', j)));
            if ndims(Ij) == 3
                % 灰階化
                Ij = rgb2gray(Ij);
            end
            % 增加到資料庫
            Tr_dataMatrix(:, end+1) = Ij(:);
            Tr_sampleLabels(:, end+1) = classnum+1;
        end
    end
end
% 取得目前標簽
classnum        =   max(Tr_sampleLabels(:));
Tr_DAT = []; trls = [];
for ci = 1:classnum
    Tr_DAT = [Tr_DAT Tr_dataMatrix(:,1+7*(ci-1)) Tr_dataMatrix(:,5+7*(ci-1):7+7*(ci-1))];
    trls   = [trls repmat(ci,[1 4])];
end

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

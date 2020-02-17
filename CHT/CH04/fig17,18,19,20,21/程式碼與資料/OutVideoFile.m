function filePath = OutVideoFile()
% 設定路徑
foldername_out = fullfile(pwd, 'video_out');
if ~exist(foldername_out, 'dir')
    % 若果資料夾不存在，則建立
    mkdir(foldername_out);
end
% 設定檔名
videoFilePath = fullfile(foldername_out, 'video_out.avi');
% 開啟交談視窗，設定路徑
[filename, pathname, ~] = uiputfile( ...
    {  '*.avi','VideoFile (*.avi)'; ...
    '*.wmv','VideoFile (*.wmv)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'VideoFile', ...
    videoFilePath);
% 起始化
filePath = 0;
if isequal(filename, 0) || isequal(pathname, 0)
    % 若果選取失效，則傳回
    return;
end
% 路徑整合
filePath = fullfile(pathname, filename);

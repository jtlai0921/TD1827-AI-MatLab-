function filePath = OutVideoFile()
% �]�w���|
foldername_out = fullfile(pwd, 'video_out');
if ~exist(foldername_out, 'dir')
    % �Y�G��Ƨ����s�b�A�h�إ�
    mkdir(foldername_out);
end
% �]�w�ɦW
videoFilePath = fullfile(foldername_out, 'video_out.avi');
% �}�ҥ�͵����A�]�w���|
[filename, pathname, ~] = uiputfile( ...
    {  '*.avi','VideoFile (*.avi)'; ...
    '*.wmv','VideoFile (*.wmv)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'VideoFile', ...
    videoFilePath);
% �_�l��
filePath = 0;
if isequal(filename, 0) || isequal(pathname, 0)
    % �Y�G������ġA�h�Ǧ^
    return;
end
% ���|��X
filePath = fullfile(pathname, filename);

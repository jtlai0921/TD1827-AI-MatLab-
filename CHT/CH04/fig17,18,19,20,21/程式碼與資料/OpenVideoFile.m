function dirName = OpenVideoFile()
% ¸ê®Æ®w¸ô®|
ImgFileName = 'mayun';
dirName = fullfile(pwd, 'data', ImgFileName, 'imgs');
dirName = uigetdir(dirName);
if isequal(dirName, 0)
    return;
end

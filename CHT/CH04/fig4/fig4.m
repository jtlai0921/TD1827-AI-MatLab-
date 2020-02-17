function dirName = GetImageFiles()
% ¸ê®Æ®w¸ô®|
ImgFileName = 'wangwenfeng';
dirName = fullfile(pwd, 'data', ImgFileName, 'daya');
dirName = uigetdir(dirName);
if isequal(dirName, 0)
    return;
end
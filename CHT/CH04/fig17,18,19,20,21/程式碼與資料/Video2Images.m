function nFrames = Video2Images(videoFilePath)
clc;
if nargin < 1
    videoFilePath = fullfile(pwd, 'video', '馬雲演講.wmv');
end
nFrames = GetVideoImgList(videoFilePath);

function nFrames = GetVideoImgList(videoFilePath)
% 取得視訊圖形序列
% 輸導入參數數：
%  vidioFilePath——視訊路徑訊息
% 輸出參數：
%  videoImgList——視訊圖形序列

xyloObj = VideoReader(videoFilePath);
% 視訊訊息
nFrames = xyloObj.NumberOfFrames;
video_imagesPath = fullfile(pwd, 'video_images');
if ~exist(video_imagesPath, 'dir')
    mkdir(video_imagesPath);
end
% 檢查是否已經處理完畢
files = dir(fullfile(video_imagesPath, '*.png'));
if length(files) == nFrames
    return;
end
% 進度指示器提示框
h = waitbar(0, '', 'Name', '取得視訊圖形序列...');
steps = nFrames;
for step = 1 : nFrames
    temp = read(xyloObj, step);
    temp_str = sprintf('%s\\%03d.png', video_imagesPath, step);
    imwrite(temp, temp_str);
    pause(0.01);
    waitbar(step/steps, h, sprintf('已處理：%d%%', round(step/nFrames*100)));
end
close(h)
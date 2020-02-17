function Images2Video(imgFilePath, filename_out)
% 清理空間
clc;
% 起始框
startnum = 1;
% 預設結束框為jpg圖形數目
endnum = size(ls(fullfile(imgFilePath, '*.jpg')), 1);
% 建立物件控制碼
writerObj = VideoWriter(filename_out);
% 設定框率
writerObj.FrameRate = 24;
% 開始開啟
open(writerObj);
% 進度指示器
h = waitbar(0, '', 'Name', 'Write Video File...');
% 總框數
steps = endnum - startnum;
for num = startnum : endnum
    % 目前序號的名稱
    file = sprintf('%04d.jpg', num);
    % 目前序號的位置
    file = fullfile(imgFilePath, file);
    % 讀取
    frame = imread(file);
    % 轉化為框物件
    frame = im2frame(frame);
    % 寫出
    writeVideo(writerObj,frame);
    % 更新
    pause(0.01);
    % 進度
    step = num - startnum;
    % 顯示進度指示器
    waitbar(step/steps, h, sprintf('Process：%d%%', round(step/steps*100)));
end
% 關閉控制碼
close(writerObj);
% 關閉進度指示器
close(h);
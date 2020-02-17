function SnapImage()
%此函數定義了抓圖動作

%如下兩行程式碼作為畫圖部分，是為了示範抓圖效果，讀者設計GUI呼叫此函數時可移除之！
subplot(1,2,1),imshow('hjj.jpg');
subplot(1,2,2),imshow('sys.jpg');

video_imagesPath = fullfile(pwd, 'snap_images');
%這一行很關鍵，制定了抓取的圖片儲存的資料夾

%下面建立圖片儲存資料夾，我們剛剛學過！
if ~exist(video_imagesPath, 'dir')
    mkdir(video_imagesPath);
end

%儲存抓圖的實現
[FileName,PathName,FilterIndex] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'儲存抓圖',...
          fullfile(pwd, 'snap_images\\temp.jpg'));
if isequal(FileName, 0) || isequal(PathName, 0)
    return;
end
%提示訊息設定
fileStr = fullfile(PathName, FileName);
f = getframe(gcf);
f = frame2im(f);
imwrite(f, fileStr);
msgbox('抓圖檔案儲存成功！', '提示訊息');
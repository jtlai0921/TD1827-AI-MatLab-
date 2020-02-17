clc;
clear all;
close all;
scale=inputdlg('規則說明(您設定的縮放比大於1，則為拉近，等於1則尺寸無變化，小於1則為拉遠)','請確定縮放比',1,{'0.5'});
% inputdlg函數會啟動一個要求使用者輸入訊息的交談視窗，呼叫格式為：
% answer =inputdlg(prompt,dlg_title,num_lines,defAns,options)
% prompt是輸入文字框的標簽；
% dlg_title是交談視窗的標題；
% num_lines是輸入文字框的行數；
% defAns是預設的文字框內容；
% options是一些可選的交談視窗選項，例如，options.Resize='on'，options. WindowStyle='normal'，options.Interpreter='tex'等。
 [filename, pathname] = uigetfile( ...
   {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
   '*.*','All Files' },...
    '請選取要修改的圖片（溫馨提示：可以同時選取任意多個）', ...
   'MultiSelect', 'on');
%%取得並整合檔名訊息
if ~iscell(filename)
   filename1{1}=filename;
else
   filename1=filename;
end
%%開始進行批次圖片縮放
for i=1:length(filename1)
   image=imread(strcat(pathname,filename1{i}));
   image_resize=imresize(image,eval(scale{1}));
%eval(s)即把字串s的內容當作敘述來執行。例如，eval ('scale{1}') 和直接在command 視窗中輸入scale{1}等效，scale函數主要是限定數值範圍（可以這樣記：scale=尺度=範圍），這裡程式碼執行結束後，讀者在command 視窗中輸入scale{1}，可以看到scale{1}等於您特殊的縮放比，與image_resize=imresize(image,eval(scale{1}))指令功能類別似的還有imagesc函數。
    imwrite(image_resize,strcat(pathname,datestr(now, 'mmddHH'),filename1{i}));
subplot(4,4,i),imshow(image_resize);%處理結果顯示，這行程式碼可以根據您計劃選取的圖片數量修改，這裡我們計劃選取4*4=16張圖片處理。
end
%批次縮放結束
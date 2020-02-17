function varargout = GUI(varargin)
% 全局變數宣告
global img_copy
global th
th=0.5;

% 下面這部分程式碼是系統預設產生的
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%至此完成起始化，接下來建立座標系
function InitAxes(handles)
% 全局變數宣告
global img_copy
global th
% 清理
clc;
% 設定預設座標系
axes(handles.axes1); cla reset;
set(handles.axes1, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000], 'Box', 'On');
% 設定按鈕起始化狀態
set(handles.FaceDet,'Enable','off');
% 設定預設窗體名稱
set(handles.figure1,'Name','基於膚色模型人臉檢驗Demo');
% 設定預設進度指示器
set(handles.slider_th,'value',0.5);
% 設定預設文字框
s=sprintf('閥值:%.1f',0.5);
set(handles.text1, 'String', s);
%開始設計動作界面了！
%第一步：
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% 起始化窗體
InitAxes(handles);
guidata(hObject, handles);
%第二步：
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%第三步：
function OpenFile_Callback(hObject, eventdata, handles)
% 全局變數宣告
global img_copy
global th
% 開啟檔案選取交談視窗
[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '請選取要測試的圖片', ...
    'on');
% 若果取消選取，則不進行動作
if isempty(filename) || isempty(filename)
    return;
end
% 顯示選取的檔案
fprintf('file=%s%s\r\n',pathname,filename);
% 產生檔案路徑
filename = fullfile(pathname, filename);
% 讀取
img = imread(filename);
% 給予值
img_copy=img;
% 顯示
axes(handles.axes1); imshow(img_copy, []);
% 設定按鈕狀態
set(handles.FaceDet,'Enable','on');
% 第四步：
function btnExit_Callback(hObject, eventdata, handles)
% 關閉窗體
close;
% 第五步：
function FaceDet_Callback(hObject, eventdata, handles)
% 全局變數宣告
global img_copy
global th
% 顯示
axes(handles.axes1); imshow(img_copy, []); hold on;
% 設定按鈕狀態
set(handles.FaceDet,'Enable','on');
% 取得目前的進度指示器數值
th=get(handles.slider_th,'value');
% 顯示
fprintf('th=%f\r\n',th);
% 呼叫檢驗函數
[boxs,num,duration] =face_detect(img_copy,th,30);
% 顯示結果
for i=1:num
    % 框選並顯示
    rectangle('Position',[boxs(i,1) boxs(i,2) boxs(i,3)-boxs(i,1)  boxs(i,4)-boxs(i,2)],'EdgeColor','r');
end
hold off;%至此人臉檢驗功能已實現
% 接下來是一些收尾工作哦
function slider_th_Callback(hObject, eventdata, handles)
% 全局變數宣告
global img_copy
global th
% 取得目前的進度指示器數值
th=get(handles.slider_th,'value');
% 設定到文字框顯示
s=sprintf('閥值:%.2f',th);
set(handles.text1, 'String', s);

function slider_th_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider_size_Callback(hObject, eventdata, handles)
% hObject    handle to slider_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function slider_size_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
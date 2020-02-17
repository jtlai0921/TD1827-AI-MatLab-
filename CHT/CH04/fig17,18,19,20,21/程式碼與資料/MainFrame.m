function varargout = MainFrame(varargin)
% MAINFRAME MATLAB code for MainFrame.fig
%      MAINFRAME, by itself, creates a new MAINFRAME or raises the existing
%      singleton*.
%
%      H = MAINFRAME returns the handle to a new MAINFRAME or the handle to
%      the existing singleton*.
%
%      MAINFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFRAME.M with the given input arguments.
%
%      MAINFRAME('Property','Value',...) creates a new MAINFRAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainFrame_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainFrame_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainFrame

% Last Modified by GUIDE v2.5 03-Jan-2018 10:02:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainFrame_OpeningFcn, ...
    'gui_OutputFcn',  @MainFrame_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before MainFrame is made visible.
function MainFrame_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainFrame (see VARARGIN)

% Choose default command line output for MainFrame
handles.output = hObject;
clc;
InitAxes(handles)
handles.videoFilePath = 0;
handles.initstate = 0;
handles.videoStop = 1;
handles.moves = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFrame wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFrame_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonPlay.
function pushbuttonPlay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.initstate, 0)
    return;
end
rand('state', 0);
dirName = handles.videoFilePath;
fpath = fullfile(dirName, '*.jpg');
img_dir = ls(fpath);
% number of frames
num = length(img_dir);
set(handles.pushbuttonPause, 'Enable', 'On');
set(handles.pushbuttonPause, 'tag', 'pushbuttonPause', 'String', '暫停');
set(handles.sliderVideoPlay, 'Max', num, 'Min', 0, 'Value', 1);
set(handles.editSlider, 'String', sprintf('%d/%d', 0, num));
% 循環載入視訊框圖形並顯示
for i = 1 : num
    waitfor(handles.pushbuttonPause,'tag','pushbuttonPause');
    I = imread(fullfile(dirName, strtrim(img_dir(i, :))));
    I = imrotate(I, -90);
    try
        imshow(I, [], 'Parent', handles.axesVideo);
        % 設定進度指示器
        set(handles.sliderVideoPlay, 'Value', i);
        set(handles.editSlider, 'String', sprintf('%d/%d', i, num));
    catch
        return;
    end
    drawnow;
end
% 控制暫停按鈕
set(handles.pushbuttonPause, 'Enable', 'Off');

% --- Executes on button press in pushbuttonOpenVideoFile.
function pushbuttonOpenVideoFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOpenVideoFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dirName = OpenVideoFile();
if isequal(dirName, 0)
    return;
end
set(handles.editVideoFilePath, 'String', dirName);
fpath = fullfile(dirName, '*.jpg');
img_dir = ls(fpath);
img = imread(fullfile(dirName, strtrim(img_dir(1, :))));
img = imrotate(img, -90);
axes(handles.axesVideo);
imshow(img, []);
NumberOfFrames = size(img_dir, 1);
img = imread(fullfile(dirName, strtrim(img_dir(1, :))));
img = imrotate(img, -90);
Width = size(img, 2);
Height = size(img, 1);
% 分析訊息並顯示到界面
set(handles.editFrameNum, 'String', sprintf('%d', NumberOfFrames));
set(handles.editFrameWidth, 'String', sprintf('%d px', Width));
set(handles.editFrameHeight, 'String', sprintf('%d px', Height));
msgbox('成功！', '提示訊息');
handles.videoFilePath = dirName;
handles.img = img;
guidata(hObject, handles);


% --- Executes on button press in pushbuttonImageList.
function pushbuttonImageList_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonImageList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.initstate, 0)
    return;
end
handles.moves = [];
rand('state', 0);
ImgFlag =1;
% initial tracker
initstate = handles.initstate;
dirName = handles.videoFilePath;
fpath = fullfile(dirName, '*.jpg');
img_dir = ls(fpath);
% number of frames
num = length(img_dir);
% the Top left corner
x = initstate(1);
y = initstate(2);
% width of the rectangle
w = initstate(3);
% height of the rectangle
h = initstate(4);
img = imread(fullfile(dirName, strtrim(img_dir(1, :))));
img = imrotate(img, -90);
if length(size(img))==3
    img = rgb2gray(img);
end
img = double(img);
% number of trained negative samples
trparams.init_negnumtrain = 50;
% radical scope of positive samples
trparams.init_postrainrad = 4;
% object position [x y width height]
trparams.initstate = initstate;
% size of search window
trparams.srchwinsz = 25;
% Classifier parameters
clfparams.width = trparams.initstate(3);
clfparams.height= trparams.initstate(4);
% feature parameters
% number of rectangle from 2 to 4.
ftrparams.minNumRect = 2;
ftrparams.maxNumRect = 4;
% number of all weaker classifiers, i.e,feature pool
M = 100;
% mean of positive features
posx.mu = zeros(M,1);
negx.mu = zeros(M,1);
% variance of positive features
posx.sig= ones(M,1);
negx.sig= ones(M,1);
% Learning rate parameter
lRate = 0.85;
% Compute feature template
[ftr.px,ftr.py,ftr.pw,ftr.ph,ftr.pwt] = HaarFtr(clfparams,ftrparams,M);
% Compute sample templates
posx.sampleImage = sampleImgDet(img,initstate,trparams.init_postrainrad,1);
negx.sampleImage = sampleImg(img,initstate,1.5*trparams.srchwinsz,4+trparams.init_postrainrad,trparams.init_negnumtrain);
% Feature extraction
% Compute integral image
iH = integral(img);
posx.feature = getFtrVal(iH,posx.sampleImage,ftr);
negx.feature = getFtrVal(iH,negx.sampleImage,ftr);
% update distribution parameters
[posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);
% 播放按鈕
set(handles.pushbuttonPause, 'Enable', 'On');
set(handles.pushbuttonPause, 'tag', 'pushbuttonPause', 'String', '暫停');
set(handles.sliderVideoPlay, 'Max', num, 'Min', 0, 'Value', 1);
set(handles.editSlider, 'String', sprintf('%d/%d', 0, num));
handles.moves = [handles.moves; initstate(1)+initstate(3)/2 initstate(2)+initstate(4)/2];
% 循環載入視訊框圖形並顯示
for i = 2 : num
    waitfor(handles.pushbuttonPause,'tag','pushbuttonPause');
    img = imread(fullfile(dirName, strtrim(img_dir(i, :))));
    img = imrotate(img, -90);
    % imgSr is used for showing tracking results
    imgSr = img;
    if length(size(img))==3
        img = rgb2gray(img);
    end
    img = double(img);
    % Compute integral image
    iH = integral(img);
    % Coarse detection
    % coarse search step
    step = 4;
    detectx.sampleImage = sampleImgDet(img,initstate,trparams.srchwinsz,step);
    detectx.feature = getFtrVal(iH,detectx.sampleImage,ftr);
    % compute the classifier for all samples
    r = ratioClassifier(posx,negx,detectx.feature);
    % linearly combine the ratio classifiers in r to the final classifier
    tmp = sum(r);
    [~,index] = max(tmp);
    x = detectx.sampleImage.sx(index);
    y = detectx.sampleImage.sy(index);
    w = detectx.sampleImage.sw(index);
    h = detectx.sampleImage.sh(index);
    initstate = [x y w h];
    % Fine detection
    step = 1;
    detectx.sampleImage = sampleImgDet(img,initstate,10,step);
    detectx.feature = getFtrVal(iH,detectx.sampleImage,ftr);
    r = ratioClassifier(posx,negx,detectx.feature);% compute the classifier for all samples
    tmp = sum(r);% linearly combine the ratio classifiers in r to the final classifier
    [c,index] = max(tmp);
    x = detectx.sampleImage.sx(index);
    y = detectx.sampleImage.sy(index);
    w = detectx.sampleImage.sw(index);
    h = detectx.sampleImage.sh(index);
    initstate = [x y w h];
    % Show the tracking results
    axes(handles.axesVideo);
    imshow(imgSr, [], 'Parent', handles.axesVideo);
    hold on;
    rectangle('Position',initstate,'LineWidth',4,'EdgeColor','r');
    hold on;
    text(5, 18, strcat('#',num2str(i)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
    pause(0.00001);
    hold off;

    % Extract samples
    posx.sampleImage = sampleImgDet(img,initstate,trparams.init_postrainrad,1);
    negx.sampleImage = sampleImg(img,initstate,1.5*trparams.srchwinsz,4+trparams.init_postrainrad,trparams.init_negnumtrain);

    % Update all the features
    posx.feature = getFtrVal(iH,posx.sampleImage,ftr);
    negx.feature = getFtrVal(iH,negx.sampleImage,ftr);
    [posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);% update distribution parameters
    
    % 設定進度指示器
    set(handles.sliderVideoPlay, 'Value', i);
    set(handles.editSlider, 'String', sprintf('%d/%d', i, num));
    handles.moves = [handles.moves; initstate(1)+initstate(3)/2 initstate(2)+initstate(4)/2];
    drawnow;

end
% 控制暫停按鈕
set(handles.pushbuttonPause, 'Enable', 'Off');
guidata(hObject, handles);
msgbox('成功！', '提示訊息');

% --- Executes on button press in pushbuttonStopCheck.
function pushbuttonStopCheck_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStopCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonPause.
function pushbuttonPause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 暫停按鈕
% 取得響應標示
str = get(handles.pushbuttonPause, 'tag');
if strcmp(str, 'pushbuttonPause') == 1
    set(handles.pushbuttonPause, 'tag', 'pushbuttonContinue', 'String', '繼續');
    pause on;
else
    set(handles.pushbuttonPause, 'tag', 'pushbuttonPause', 'String', '暫停');
    pause off;
end

% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 停止按鈕
InitAxes(handles)
set(handles.editSlider, 'String', '0/0');
set(handles.sliderVideoPlay, 'Value', 0);
set(handles.pushbuttonPause, 'tag', 'pushbuttonContinue', 'String', '繼續');
set(handles.pushbuttonPause, 'Enable', 'Off');
set(handles.pushbuttonPause, 'String', '暫停');


function editFrameNum_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameNum as text
%        str2double(get(hObject,'String')) returns contents of editFrameNum as a double


% --- Executes during object creation, after setting all properties.
function editFrameNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameWidth_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameWidth as text
%        str2double(get(hObject,'String')) returns contents of editFrameWidth as a double


% --- Executes during object creation, after setting all properties.
function editFrameWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameHeight_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameHeight as text
%        str2double(get(hObject,'String')) returns contents of editFrameHeight as a double


% --- Executes during object creation, after setting all properties.
function editFrameHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrameRate_Callback(hObject, eventdata, handles)
% hObject    handle to editFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrameRate as text
%        str2double(get(hObject,'String')) returns contents of editFrameRate as a double


% --- Executes during object creation, after setting all properties.
function editFrameRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVideoFilePath_Callback(hObject, eventdata, handles)
% hObject    handle to editVideoFilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVideoFilePath as text
%        str2double(get(hObject,'String')) returns contents of editVideoFilePath as a double


% --- Executes during object creation, after setting all properties.
function editVideoFilePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVideoFilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonGetVideoInfo.
function pushbuttonGetVideoInfo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGetVideoInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.videoFilePath == 0
    msgbox('請載入視訊檔案！', '提示訊息');
    return;
end
InitAxes(handles);
axes(handles.axesVideo);
imshow(handles.img, []);
hold on;
initstate = [0.3750*size(handles.img, 2) 0.2292*size(handles.img, 1) 0.2344*size(handles.img, 2) 0.3958*size(handles.img, 1)];
h = imrect(handles.axesVideo, initstate);
rect = wait(h);
rect = round(rect);
rectangle('Position', rect, 'LineWidth', 4, 'EdgeColor', 'r');
text(5, 18, strcat('#',num2str(1)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
hold off;
set(handles.editRectangle, 'String', sprintf('[%d %d %d %d]', rect(1), rect(2), rect(3), rect(4)));
msgbox('成功！', '提示訊息');
handles.initstate = rect;
guidata(hObject, handles);

function editDuration_Callback(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDuration as text
%        str2double(get(hObject,'String')) returns contents of editDuration as a double


% --- Executes during object creation, after setting all properties.
function editDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVideoFormat_Callback(hObject, eventdata, handles)
% hObject    handle to editVideoFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVideoFormat as text
%        str2double(get(hObject,'String')) returns contents of editVideoFormat as a double


% --- Executes during object creation, after setting all properties.
function editVideoFormat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVideoFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSnap.
function pushbuttonSnap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSnap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 抓圖按鈕響應函數
SnapImage();

% --- Executes on slider movement.
function sliderVideoPlay_Callback(hObject, eventdata, handles)
% hObject    handle to sliderVideoPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderVideoPlay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderVideoPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function editSlider_Callback(hObject, eventdata, handles)
% hObject    handle to editSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSlider as text
%        str2double(get(hObject,'String')) returns contents of editSlider as a double


% --- Executes during object creation, after setting all properties.
function editSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInfo_Callback(hObject, eventdata, handles)
% hObject    handle to editInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInfo as text
%        str2double(get(hObject,'String')) returns contents of editInfo as a double


% --- Executes during object creation, after setting all properties.
function editInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonExit.
function pushbuttonExit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 離開系統按鈕
choice = questdlg('確定要離開系統?', ...
    '離開', ...
    '確定','取消','取消');
switch choice
    case '確定'
        close;
    case '取消'
        return;
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exist_Callback(hObject, eventdata, handles)
% hObject    handle to Exist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 離開選單
choice = questdlg('確定要離開系統?', ...
    '離開', ...
    '確定','取消','取消');
switch choice
    case '確定'
        close;
    case '取消'
        return;
end

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = '視訊處理系統V1.0';
msgbox(str, '提示訊息');



function edit_videowidth_Callback(hObject, eventdata, handles)
% hObject    handle to edit_videowidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_videowidth as text
%        str2double(get(hObject,'String')) returns contents of edit_videowidth as a double


% --- Executes during object creation, after setting all properties.
function edit_videowidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_videowidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRectangle_Callback(hObject, eventdata, handles)
% hObject    handle to editRectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRectangle as text
%        str2double(get(hObject,'String')) returns contents of editRectangle as a double


% --- Executes during object creation, after setting all properties.
function editRectangle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% 設定背景
% ha = axes('units','normalized','position',[0 0 1 1]);
% uistack(ha, 'bottom')
% bg = imread('bg.jpg');
% image(bg);
% set(ha,'handlevisibility','off','visible','off');


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 運動軌跡分析
if isempty(handles.moves)
    return;
end
axes(handles.axesVideo); 
plot(handles.moves(:, 1), handles.moves(:, 2), 'r*-');
axis off; axis ij;

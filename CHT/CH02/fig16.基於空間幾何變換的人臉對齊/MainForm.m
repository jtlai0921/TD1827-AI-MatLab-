function varargout = MainForm(varargin)
% MAINFORM MATLAB code for MainForm.fig
%      MAINFORM, by itself, creates a new MAINFORM or raises the existing
%      singleton*.
%
%      H = MAINFORM returns the handle to a new MAINFORM or the handle to
%      the existing singleton*.
%
%      MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFORM.M with the given input arguments.
%
%      MAINFORM('Property','Value',...) creates a new MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainForm

% Last Modified by GUIDE v2.5 18-Dec-2017 22:38:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainForm_OpeningFcn, ...
                   'gui_OutputFcn',  @MainForm_OutputFcn, ...
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


% --- Executes just before MainForm is made visible.
function MainForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainForm (see VARARGIN)

% Choose default command line output for MainForm
handles.output = hObject;
global landmark
global Img

axes(handles.axes1); box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes2); box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainForm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img
imgfilePath = fullfile(pwd, 'images/wwf.jpg');
[filename, pathname, filterindex] = uigetfile( ...
    { '*.jpg','All jpg Files';...
    '*.bmp','All bmp Files';...
    '*.*',  '�Ҧ��ɮ� (*.*)'}, ...
    '����ɮ�', ...
    'MultiSelect', 'off', ...
    imgfilePath);
filePath = 0;
if isequal(filename, 0) || isequal(pathname, 0)
    return;
end
filePath = fullfile(pathname, filename);
Img = imread(filePath);
axes(handles.axes1); 
imshow(Img , []);
title('��ϧ�');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img

% �ت��ϧΤj�p
rows = 160;
cols = 150;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.3;
colFrac = 0.7;
% ���T�I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
mouth = [0.5*cols,rows*(1-rowFrac),];
landmark_tool = [le; re; mouth];
% �o���g�ܴ�
tform1 = cp2tform(landmark_tool,landmark,'affine');
% �o��ت��ϧ�
result1 = imtransform(Img,tform1);
axes(handles.axes2); 
imshow(result1 , []);
title('�T�I�����k1');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img

% �ت��ϧΤj�p
rows = 150;
cols = 160;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.3;
colFrac = 0.7;
% ���T�I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
mouth = [0.5*cols,rows*(1-rowFrac),];
landmark_tool = [le; re; mouth];
% �o���g�ܴ�
tform2 = fitgeotrans(landmark,landmark_tool,'affine');
% �o��ت��ϧ�
result2 = imwarp(Img,tform2,'outputview',imref2d(size(targetimage)));
axes(handles.axes2); 
imshow(result2 , []);
title('�T�I�����k2');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img

% �ت��ϧΤj�p
rows = 150;
cols = 160;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.3;
colFrac = 0.7;
% ���T�I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
mouth = [0.5*cols,rows*(1-rowFrac),];
landmark_tool = [le; re; mouth];
% �o���g�ܴ�
tform3 = estimateGeometricTransform(landmark,landmark_tool,'affine');
% �o��ت��ϧ�
result3 = imwarp(Img,tform3,'outputview',imref2d(size(targetimage)));
axes(handles.axes2); 
imshow(result3 , []);
title('�T�I�����k3');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img

% �ت��ϧΤj�p
rows = 150;
cols = 160;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.3;
colFrac = 0.7;
% �����I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
landmark_tool = [le; re];
% �o���L���A���Ŷ��ܴ�
tform1 = fitgeotrans(landmark,landmark_tool,'NonreflectiveSimilarity');
% �o��ت��ϧ�
result1 = imwarp(Img,tform1,'outputview',imref2d(size(targetimage)));
axes(handles.axes2); 
imshow(result1 , []);
title('�G�I�����k1');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img

% �ت��ϧΤj�p
rows = 150;
cols = 160;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.3;
colFrac = 0.7;
% �����I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
landmark_tool = [le; re];
% �o���L���A���Ŷ��ܴ�
tform2 = estimateGeometricTransform(landmark,landmark_tool,'Similarity');
% �o��ت��ϧ�
result2 = imwarp(Img,tform2,'outputview',imref2d(size(targetimage)));
axes(handles.axes2); 
imshow(result2 , []);
title('�G�I�����k2');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img
axes(handles.axes1); imshow(Img, []);
hold on;
landmark=[];
% �S���I�Ӽ�
TOLNUM=3;
for k=1:TOLNUM
    % ���I
    a=ginput(1);
    % ø��
    plot(a(1),a(2),'r+');
    % �x�s
    landmark=[landmark;a];
end
hold off;


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global landmark
global Img
axes(handles.axes1); imshow(Img, []);
hold on;
landmark=[];
% �S���I�Ӽ�
TOLNUM=2;
for k=1:TOLNUM
    % ���I
    a=ginput(1);
    % ø��
    plot(a(1),a(2),'r+');
    % �x�s
    landmark=[landmark;a];
end
hold off;

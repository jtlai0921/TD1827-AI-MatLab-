function varargout = GUI(varargin)
% �����ܼƫŧi
global img_copy
global th
th=0.5;

% �U���o�����{���X�O�t�ιw�]���ͪ�
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
%�ܦ������_�l�ơA���U�ӫإ߮y�Шt
function InitAxes(handles)
% �����ܼƫŧi
global img_copy
global th
% �M�z
clc;
% �]�w�w�]�y�Шt
axes(handles.axes1); cla reset;
set(handles.axes1, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000], 'Box', 'On');
% �]�w���s�_�l�ƪ��A
set(handles.FaceDet,'Enable','off');
% �]�w�w�]����W��
set(handles.figure1,'Name','��󽧦�ҫ��H�y����Demo');
% �]�w�w�]�i�׫��ܾ�
set(handles.slider_th,'value',0.5);
% �]�w�w�]��r��
s=sprintf('�֭�:%.1f',0.5);
set(handles.text1, 'String', s);
%�}�l�]�p�ʧ@�ɭ��F�I
%�Ĥ@�B�G
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% �_�l�Ƶ���
InitAxes(handles);
guidata(hObject, handles);
%�ĤG�B�G
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%�ĤT�B�G
function OpenFile_Callback(hObject, eventdata, handles)
% �����ܼƫŧi
global img_copy
global th
% �}���ɮ׿����͵���
[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '�п���n���ժ��Ϥ�', ...
    'on');
% �Y�G��������A�h���i��ʧ@
if isempty(filename) || isempty(filename)
    return;
end
% ��ܿ�����ɮ�
fprintf('file=%s%s\r\n',pathname,filename);
% �����ɮ׸��|
filename = fullfile(pathname, filename);
% Ū��
img = imread(filename);
% ������
img_copy=img;
% ���
axes(handles.axes1); imshow(img_copy, []);
% �]�w���s���A
set(handles.FaceDet,'Enable','on');
% �ĥ|�B�G
function btnExit_Callback(hObject, eventdata, handles)
% ��������
close;
% �Ĥ��B�G
function FaceDet_Callback(hObject, eventdata, handles)
% �����ܼƫŧi
global img_copy
global th
% ���
axes(handles.axes1); imshow(img_copy, []); hold on;
% �]�w���s���A
set(handles.FaceDet,'Enable','on');
% ���o�ثe���i�׫��ܾ��ƭ�
th=get(handles.slider_th,'value');
% ���
fprintf('th=%f\r\n',th);
% �I�s������
[boxs,num,duration] =face_detect(img_copy,th,30);
% ��ܵ��G
for i=1:num
    % �ؿ�����
    rectangle('Position',[boxs(i,1) boxs(i,2) boxs(i,3)-boxs(i,1)  boxs(i,4)-boxs(i,2)],'EdgeColor','r');
end
hold off;%�ܦ��H�y����\��w��{
% ���U�ӬO�@�Ǧ����u�@�@
function slider_th_Callback(hObject, eventdata, handles)
% �����ܼƫŧi
global img_copy
global th
% ���o�ثe���i�׫��ܾ��ƭ�
th=get(handles.slider_th,'value');
% �]�w���r�����
s=sprintf('�֭�:%.2f',th);
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
%%�D��Ʃw�q�G
function nFrames = Video2Images(videoFilePath)
% ��ɤJ�ѼƼơG
%  videoFilePath�X�X���T���|�T��
% ��X�ѼơG
%  videoImgList�X�X���T�ϧΧǦC
clc;
if nargin < 1
    videoFilePath = fullfile(pwd, 'video', 'wangyanbo.avi');
%�o�@�������I�w�q�F���T���|�]�Ҧb��Ƨ��^�ε��T�ɮת��W�١]�t���ɦW�^�C
end
nFrames = GetVideoImgList(videoFilePath);
%%�l��Ʃw�q
function nFrames = GetVideoImgList(videoFilePath)
% ���o���T�ϧΧǦC
% ��ɤJ�ѼƼơG
%  videoFilePath�X�X���T���|�T��
% ��X�ѼơG
%  videoImgList�X�X���T�ϧΧǦC
xyloObj = VideoReader(videoFilePath);
% ���T�T��
nFrames = xyloObj.NumberOfFrames;
video_imagesPath = fullfile(pwd, 'video_images');
%�o�@��]������A�إ�video_images��Ƨ��A�H�x�s�ѵ��T�ഫ���o���ϧΧǦC
if ~exist(video_imagesPath, 'dir')
    mkdir(video_imagesPath);
end
% �ˬd�O�_�w�g�B�z����
files = dir(fullfile(video_imagesPath, '*.png'));
if length(files) == nFrames
    return;
end
% �i�׫��ܾ����ܮ�
h = waitbar(0, '', 'Name', '���o���T�ϧΧǦC...');
steps = nFrames;
for step = 1 : nFrames
    temp = read(xyloObj, step);
    temp_str = sprintf('%s\\%03d.png', video_imagesPath, step);
    imwrite(temp, temp_str);
    pause(0.01);
    waitbar(step/steps, h, sprintf('�w�B�z�G%d%%', round(step/nFrames*100)));
end
close(h)
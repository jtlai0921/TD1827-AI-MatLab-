clc;
clear all;
close all;
videoFilePath = fullfile(pwd, 'video', 'wangyanbo.avi');
%���wvideo��Ƨ��U�����Twangyanbo.avi�@��Ū������
obj = VideoReader(videoFilePath);
%�Y�G���ȷQŪ�����T�A�ٷQ�n��ܩM�x�s�C�@�ءA����i�H�o�˹�{�G
numFrames = obj.NumberOfFrames;% �ت��`��
for k = 1 : numFrames% Ū�����
    frame = read(obj,k);
    imshow(frame);%��ܨC�@��
f=getframe(gcf);
    ImagesPath = 'D:\wybimages\'; 
%���w��Ƨ��A�Ъ`�N�o�Ӹ�Ƨ������s�b�B�̦n�O�Ÿ�Ƨ��I
%�������A�A�ݭn�b�{�����椧�e���إߦn�o�ӭp���Ψ��x�s�ϧΪ��Ÿ�Ƨ�
%��M�A�A�]�i�H��mkdir��ƦbMATLAB�{���X�̫إ߳o�Ӹ�Ƨ��A�U�夶�Ц���ơC
imwrite(f.cdata,[ImagesPath,strcat(num2str(k),'.jpg')]);
% �x�s�C�@�ب�S����Ƨ�
end
function SnapImage()
%����Ʃw�q�F��ϰʧ@

%�p�U���{���X�@���e�ϳ����A�O���F�ܽd��ϮĪG�AŪ�̳]�pGUI�I�s����Ʈɥi�������I
subplot(1,2,1),imshow('hjj.jpg');
subplot(1,2,2),imshow('sys.jpg');

video_imagesPath = fullfile(pwd, 'snap_images');
%�o�@�������A��w�F������Ϥ��x�s����Ƨ�

%�U���إ߹Ϥ��x�s��Ƨ��A�ڭ̭��ǹL�I
if ~exist(video_imagesPath, 'dir')
    mkdir(video_imagesPath);
end

%�x�s��Ϫ���{
[FileName,PathName,FilterIndex] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'�x�s���',...
          fullfile(pwd, 'snap_images\\temp.jpg'));
if isequal(FileName, 0) || isequal(PathName, 0)
    return;
end
%���ܰT���]�w
fileStr = fullfile(PathName, FileName);
f = getframe(gcf);
f = frame2im(f);
imwrite(f, fileStr);
msgbox('����ɮ��x�s���\�I', '���ܰT��');
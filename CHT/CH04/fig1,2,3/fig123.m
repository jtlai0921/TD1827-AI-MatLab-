clc;
clear all;
close all;
scale=inputdlg('�W�h����(�z�]�w���Y���j��1�A�h���Ԫ�A����1�h�ؤo�L�ܤơA�p��1�h���Ի�)','�нT�w�Y���',1,{'0.5'});
% inputdlg��Ʒ|�Ұʤ@�ӭn�D�ϥΪ̿�J�T������͵����A�I�s�榡���G
% answer =inputdlg(prompt,dlg_title,num_lines,defAns,options)
% prompt�O��J��r�ت���ñ�F
% dlg_title�O��͵��������D�F
% num_lines�O��J��r�ت���ơF
% defAns�O�w�]����r�ؤ��e�F
% options�O�@�ǥi�諸��͵����ﶵ�A�Ҧp�Aoptions.Resize='on'�Aoptions. WindowStyle='normal'�Aoptions.Interpreter='tex'���C
 [filename, pathname] = uigetfile( ...
   {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
   '*.*','All Files' },...
    '�п���n�ק諸�Ϥ��]���ɴ��ܡG�i�H�P�ɿ�����N�h�ӡ^', ...
   'MultiSelect', 'on');
%%���o�þ�X�ɦW�T��
if ~iscell(filename)
   filename1{1}=filename;
else
   filename1=filename;
end
%%�}�l�i��妸�Ϥ��Y��
for i=1:length(filename1)
   image=imread(strcat(pathname,filename1{i}));
   image_resize=imresize(image,eval(scale{1}));
%eval(s)�Y��r��s�����e��@�ԭz�Ӱ���C�Ҧp�Aeval ('scale{1}') �M�����bcommand ��������Jscale{1}���ġAscale��ƥD�n�O���w�ƭȽd��]�i�H�o�˰O�Gscale=�ث�=�d��^�A�o�̵{���X���浲����AŪ�̦bcommand ��������Jscale{1}�A�i�H�ݨ�scale{1}����z�S���Y���A�Pimage_resize=imresize(image,eval(scale{1}))���O�\�����O�����٦�imagesc��ơC
    imwrite(image_resize,strcat(pathname,datestr(now, 'mmddHH'),filename1{i}));
subplot(4,4,i),imshow(image_resize);%�B�z���G��ܡA�o��{���X�i�H�ھڱz�p��������Ϥ��ƶq�ק�A�o�̧ڭ̭p�����4*4=16�i�Ϥ��B�z�C
end
%�妸�Y�񵲧�
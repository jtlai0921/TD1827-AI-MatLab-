%%�]�w���|
tem_facedata = cd;
par.d_facedata          =   [cd '/database/'];
addpath([cd '/RUNTIME/']);

%%�]�w�Ѽ�
classnum        =   100;   %�˥���
par.nSample       =   7;   %�P�@�˥����˼�
par.ID            =   [];
par.nameDatabase  =   'AR_disguise';

%%���J�H�y��ƶ�
load([par.d_facedata 'AR_database']);
% �ۭq��Ƨ��A�Ω�[�J�ۤv���H�y���
folder_add = fullfile(pwd, 'database', 'face_add');
folder_adds = dir(folder_add);

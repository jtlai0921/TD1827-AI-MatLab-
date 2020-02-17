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
for i = 1 : length(folder_adds)
    if folder_adds(i).isdir == 1 && ~isequal(folder_adds(i).name, '.') && ~isequal(folder_adds(i).name, '..')
%Ū�̽оڦ���{���X�i�@�B�A��isequal��ƥΪk
        
% �}�lŪ���ۭq��Ƨ��A�[�J�s��ƨ�AR_database
        folder_add_j = fullfile(folder_add, folder_adds(i).name);
        % ���o�ثe��ñ
        classnum        =   max(Tr_sampleLabels(:));
%��Ū�̭��I�A�Ѥ@�U�o�̬������o�˨��o�ثe��ñ
        for j = 1 : 7
            % Ū���H�y�ϧ�
            Ij = imread(fullfile(folder_add_j, sprintf('%02d.jpg', j)));
            if ndims(Ij) == 3
                % �Ƕ���
                Ij = rgb2gray(Ij);
            end
            % �W�[���Ʈw
            Tr_dataMatrix(:, end+1) = Ij(:);
            Tr_sampleLabels(:, end+1) = classnum+1;
        end
    end
end
% ���o�ثe��ñ
classnum        =   max(Tr_sampleLabels(:));
Tr_DAT = []; trls = [];
for ci = 1:classnum
    Tr_DAT = [Tr_DAT Tr_dataMatrix(:,1+7*(ci-1)) Tr_dataMatrix(:,5+7*(ci-1):7+7*(ci-1))];
    trls   = [trls repmat(ci,[1 4])];
end

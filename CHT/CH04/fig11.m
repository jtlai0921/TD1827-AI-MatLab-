clc;
%%�Ĥ@�h��Ƨ��s�b�P�_�P�w�Ϋإ�
if ~exist('C:\Users\wwf\Desktop\��4��/wyb');
top_folder =  'C:\Users\wwf\Desktop\��4��/wyb'; % �Ĥ@�h��Ƨ��W��
mkdir(top_folder); % �إ߲Ĥ@�h��Ƨ�
end

%%�ĤG�h��Ƨ��s�b�P�_�P�w�Ϋإ�
if ~exist('C:\Users\wwf\Desktop\��4��\wyb/images');
second_folder = sprintf('%s/%s',top_folder,'images'); %�غc�ĤG�h��Ƨ��W��
mkdir(second_folder); % �إ߲ĤG�h��Ƨ�
end

%%�ĤT�h��Ƨ��s�b�P�_�P�w�Ϋإ�
if ~exist('C:\Users\wwf\Desktop\��4��\wyb\images/20180106');
third_folder = sprintf('%s/%s', second_folder, '20180106'); % �غc�ĤT�h��Ƨ��W��(�C�����O�̫�@�h�غc����Ƨ��W�٫e�α׺b�A�䥦���O�ϱ׺b)�C
mkdir(third_folder); % �إ߲ĤT�h��Ƨ� 
end
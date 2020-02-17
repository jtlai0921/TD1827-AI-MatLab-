function [ro_data, rt_data, ru_label] = Data_PreProcess(r_data, r_label, input_file)
% ���o�ثe�����O��
class_num = max(r_label(:));
% ��X���
ru_data = [];
ru_label = [];
for i = 1 : class_num
    ru_data = [ru_data r_data(:,1+7*(i-1)) r_data(:,5+7*(i-1):7+7*(i-1))];
    ru_label = [ru_label repmat(i,[1 4])];
end
% Ū����J�ϧ�
tu_data = imread(input_file);
if ndims(tu_data) == 3
    tu_data = rgb2gray(tu_data);
end
% �����˰Ѽ�
im_h = 84;
im_w = 60;
% �����˹ϧθ��
ro_data = [];
for i = 1:size(ru_data,2)
    % ���R�˥�
    tmp = reshape(ru_data(:,i),[165 120]);
    % ������
    tmp = uint8(imresize(tmp, [im_h im_w]));
    % �x�s
    ro_data(:,i) = tmp(:);
end
rt_data = [];
for i = 1:1
    % ���R�˥�
    tmp = tu_data;
    % ������
    tmp = uint8(imresize(tmp,[im_h im_w]));
    % �x�s
    rt_data(:,i) = tmp(:);
end
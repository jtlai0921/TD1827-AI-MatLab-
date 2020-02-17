function Images2Video(imgFilePath, filename_out)
% �M�z�Ŷ�
clc;
% �_�l��
startnum = 1;
% �w�]�����ج�jpg�ϧμƥ�
endnum = size(ls(fullfile(imgFilePath, '*.jpg')), 1);
% �إߪ��󱱨�X
writerObj = VideoWriter(filename_out);
% �]�w�زv
writerObj.FrameRate = 24;
% �}�l�}��
open(writerObj);
% �i�׫��ܾ�
h = waitbar(0, '', 'Name', 'Write Video File...');
% �`�ؼ�
steps = endnum - startnum;
for num = startnum : endnum
    % �ثe�Ǹ����W��
    file = sprintf('%04d.jpg', num);
    % �ثe�Ǹ�����m
    file = fullfile(imgFilePath, file);
    % Ū��
    frame = imread(file);
    % ��Ƭ��ت���
    frame = im2frame(frame);
    % �g�X
    writeVideo(writerObj,frame);
    % ��s
    pause(0.01);
    % �i��
    step = num - startnum;
    % ��ܶi�׫��ܾ�
    waitbar(step/steps, h, sprintf('Process�G%d%%', round(step/steps*100)));
end
% ��������X
close(writerObj);
% �����i�׫��ܾ�
close(h);
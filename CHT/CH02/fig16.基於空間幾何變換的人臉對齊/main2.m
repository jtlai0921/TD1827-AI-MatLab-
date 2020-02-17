clc; clear all; close all;
% �ت��ϧΤj�p
rows = 200;
cols = 200;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.35;
colFrac = 0.65;
% �����I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
landmark_tool = [le; re];
% Ū���ɮ�
Fname=fullfile(pwd, 'images', 'wwf.jpg');
inputimage=imread(Fname);
figure;
imshow(inputimage);
hold on;
landmark=[];
% �S���I�Ӽ�
TOLNUM=2;
for k=1:TOLNUM
    % ���I
    a=ginput(1);
    % ø��
    plot(a(1),a(2),'r+');
    % �x�s
    landmark=[landmark;a];
end
hold off;

% �o���L���A���Ŷ��ܴ�
tform1 = fitgeotrans(landmark,landmark_tool,'NonreflectiveSimilarity');
% �o��ت��ϧ�
result1 = imwarp(inputimage,tform1,'outputview',imref2d(size(targetimage)));

% �o���L���A���Ŷ��ܴ�
tform2 = estimateGeometricTransform(landmark,landmark_tool,'Similarity');
% �o��ت��ϧ�
result2 = imwarp(inputimage,tform2,'outputview',imref2d(size(targetimage)));

figure;
imshow(result1);
figure;
imshow(result2);
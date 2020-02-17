clc; clear all; close all;
% �ت��ϧΤj�p
rows = 200;
cols = 200;
% �ت��ϧ�
targetimage = zeros(rows,cols);
% �Ω�w�q�S���I��m���t��
rowFrac = 0.35;
colFrac = 0.65;
% ���T�I���S���I�y��
le = [(1-colFrac)*cols,rows*rowFrac];
re = [colFrac*cols,rows*rowFrac];
mouth = [0.5*cols,rows*(1-rowFrac),];
landmark_tool = [le; re; mouth];
% Ū���ɮ�
Fname=fullfile(pwd, 'images', 'wwf.jpg');
inputimage=imread(Fname);%Ū�J�ϧ�
figure;
imshow(inputimage);
hold on;
landmark=[];
% �S���I�Ӽ�
TOLNUM=3;
for k=1:TOLNUM
    % ���I
    a=ginput(1);
    % ø��
    plot(a(1),a(2),'r+');
    % �x�s
    landmark=[landmark;a];
end
hold off;
% �o���g�ܴ�
tform1 = cp2tform(landmark_tool,landmark,'affine');
% �o��ت��ϧ�
result1 = imtransform(inputimage,tform1);

% �o���g�ܴ�
tform2 = fitgeotrans(landmark,landmark_tool,'affine');
% �o��ت��ϧ�
result2 = imwarp(inputimage,tform2,'outputview',imref2d(size(targetimage)));

% �o���g�ܴ�
tform3 = estimateGeometricTransform(landmark,landmark_tool,'affine');
% �o��ت��ϧ�
result3 = imwarp(inputimage,tform3,'outputview',imref2d(size(targetimage)));

% ���
figure;
imshow(result1);
figure;
imshow(result2);
figure;
imshow(result3);
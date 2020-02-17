clc; clear all;
IM = imread('3.jpg'); bw = rgb2gray(IM); L = bwlabel(bw);
Area = regionprops(L,'Area');
% �p��X�b�ϧΦU�Ӱϰ줤�����`�Ӽ�
BoundingBox = regionprops(L,'BoundingBox');
% �]�A�����ϰ쪺�̤p�x��
Centroid = regionprops(L,'Centroid');
% �C�Ӱϰ쪺��ߡ]���ߡ^
MajorAxisLength = regionprops(L,'MajorAxisLength');
% �P�ϰ�㦳�ۦP�Э�G�����߯x����ꪺ���b���ס]�����N�q�U�^�F���O�����׶q����٦�MinorAxisLength�A�PMajorAxisLength���Ϊk�]�O���O����.
Eccentricity = regionprops(L,'Eccentricity');
% �P�ϰ�㦳�ۦP�Э�G�����߯x����ꪺ���߲v�]�i�@���S���^
Orientation = regionprops(L,'Eccentricity');
% �P�ϰ�㦳�ۦP�Э�G�����߯x����ꪺ���b�Px�b���樤�]�ס^
Image = regionprops(L,'Image');
% �P�Y�ϰ�㦳�ۦP�j�p���޿�x�}
FilledImage = regionprops(L,'FilledImage');
% �P�Y�ϰ즳�ۦP�j�p����R�޿�x�}
FilledArea = regionprops(L,'FilledArea');
% ��R�ϰ�ϧΤ���on�����Ӽ�
ConvexHull = regionprops(L,'ConvexHull');
% �]�A�Y�ϰ쪺�̤p�Y�h���
ConvexImage = regionprops(L,'ConvexImage');
% �e�X�W�z�ϰ�̤p�Y�h���
ConvexArea = regionprops(L,'ConvexArea');
% ��R�ϰ�Y�h��ιϧΤ���on�����Ӽ�
EulerNumber = regionprops(L,'EulerNumber');
% �X��ݼ����ܼơX�X�کԼ�
Extrema = regionprops(L,'EulerNumber');
% �K��V�ϰ췥���I
EquivDiameter = regionprops(L,'EquivDiameter');
% �P�ϰ�㦳�ۦP���n���ꪺ���|
Solidity = regionprops(L,'Solidity');
% �P�ɦb�ϰ�M��̤p�Y�h��Τ����������
Extent = regionprops(L,'Extent');
% �P�ɦb�ϰ�M��̤p��ɯx�Τ����������
PixelIdxList = regionprops(L,'PixelIdxList');
% �x�s�ϰ칳�������ޯ���
PixelList = regionprops(L,'PixelIdxList');
% �x�s�W�z���޹����������y��

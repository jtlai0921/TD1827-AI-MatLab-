%  demo_3D_Face_Matching.m
%  Author: Yulan Guo {yulan.guo@nudt.edu.cn}
%  NUDT, China & CSSE, UWA, Australia
% This function performs feature matching on two 3D faces to obtain feature correspondences
% Homepage of YULAN GUO: http://yulanguo.me/

close all;
clc;
clear all;

keypntNum = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %============================load a 3D face============================%
[mesh.vertices, mesh.faces]   = read_mesh('Data\02463d452.ply');
%============================preprocessing============================%
out = preprocessingFunc(mesh);
mesh.faceCenter = out.centroid;
mesh.faceArea = out.area;
mesh.res = out.res ;
%============================detect keypoints============================%
%keypoints are randomly seleted in this demo, any 3D keypoint detection method can be used
keypntNum = 100;
temp = randperm(length(mesh.vertices));
mesh.keypntIdx = temp(1:keypntNum);
%============================extract RoPS features at the keypoints on a mesh============================%
para.RoPS_nbSize = 15*mesh.res;
para.RoPS_binSize = 5;
para.RoPS_rotaSize = 3;
mesh.LRF =  LRFforMeshFunc(mesh, mesh.keypntIdx, para.RoPS_nbSize);
disp('LRFs calculated');  
RoPS = RoPSFunc(mesh, para.RoPS_nbSize, para.RoPS_binSize, para.RoPS_rotaSize,mesh.LRF);
mesh.RoPS = RoPS;
disp(['RoPS features generated']);  
mesh1 = mesh;
mesh1Features = [];
for keypntIdx = 1:keypntNum
    temp = trans2Dto1DFunc(mesh.RoPS{keypntIdx});
    mesh1Features = [mesh1Features; temp];
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %============================load a 3D face============================%
[mesh.vertices, mesh.faces]   = read_mesh('Data\02463d464.ply');
%============================preprocessing============================%
out = preprocessingFunc(mesh);
mesh.faceCenter = out.centroid;
mesh.faceArea = out.area;
mesh.res = out.res ;
%============================detect keypoints============================%
%keypoints are randomly seleted in this demo, any 3D keypoint detection method can be used
keypntNum = 100;
temp = randperm(length(mesh.vertices));
mesh.keypntIdx = temp(1:keypntNum);
%============================extract RoPS features at the keypoints on a mesh============================%
para.RoPS_nbSize = 15*mesh.res;
para.RoPS_binSize = 5;
para.RoPS_rotaSize = 3;
mesh.LRF =  LRFforMeshFunc(mesh, mesh.keypntIdx, para.RoPS_nbSize);
disp('LRFs calculated');  
RoPS = RoPSFunc(mesh, para.RoPS_nbSize, para.RoPS_binSize, para.RoPS_rotaSize,mesh.LRF);
mesh.RoPS = RoPS;
disp(['RoPS features generated']);  
mesh2 = mesh;
mesh2Features = [];
for keypntIdx = 1:keypntNum
    temp = trans2Dto1DFunc(mesh.RoPS{keypntIdx});
    mesh2Features = [mesh2Features; temp];
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %============================feature matching============================%
NNDRthreshold = 0.9;
corNum = 0;
kdtreeMesh1Features = KDTreeSearcher(mesh1Features,'Distance','euclidean');
for keypntIdx1 = 1:size(mesh2Features,1)
    [idxSort,distSort] = knnsearch(kdtreeMesh1Features, mesh2Features(keypntIdx1,:),'k',2,'Distance','euclidean');
    IDX = idxSort(1);
    if distSort(1)/distSort(2)<=NNDRthreshold
        corNum = corNum+1;
        corPntIdx(corNum,:) = [IDX, keypntIdx1];
        featureDis(corNum) = distSort(1);
    end
end

rollAngle = -90;
R = [1,0,0; 0,cos(rollAngle*pi/180),sin(rollAngle*pi/180); 0, -sin(rollAngle*pi/180), cos(rollAngle*pi/180)]';
mesh1.vertices = mesh1.vertices*R;
mesh2.vertices = mesh2.vertices*R;

showCorresFunc(mesh1, mesh2, mesh1.keypntIdx(corPntIdx(:,1)), mesh2.keypntIdx(corPntIdx(:,2)), [200,0,0]);




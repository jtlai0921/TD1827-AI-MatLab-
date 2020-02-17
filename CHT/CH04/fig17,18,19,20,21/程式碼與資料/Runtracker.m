% Demo for paper "Fast Compressive Tracking,"Kaihua Zhang, Lei Zhang, and Ming-Hsuan Yang
% Submitted to TPAMI. 
% Implemented by Kaihua Zhang, Dept.of Computing, HK PolyU.
% Email: zhkhua@gmail.com
% Date: 11/12/2011
% Revised by Kaihua Zhang, 15/12/2011
% Revised by Kaihua Zhang, 11/7/2012
% Revised by Kaihua Zhang, 26/10/2012
% Revised by Kaihua Zhang, 7/1/2013
clc;clear all;close all;
rand('state',0);
%randstrem('state');
%% Select video sequences   
ImgFlag =1;%1,david,2,tiger2,3,sylvester,4,twinnings,5,cliffbar...
%% 
[ImgFileName,initstate] = initCt(ImgFlag);%initial tracker
%%Set path
pathName = strcat('.\data\',ImgFileName);
addpath(pathName,strcat(pathName,'\imgs'));
fpath = fullfile(strcat(pathName,'\imgs'),'*.png');
addpath(pathName);
img_dir = dir(fpath)
num = length(img_dir);% number of frames
%%
x = initstate(1);% x axis at the Top left corner
y = initstate(2);
w = initstate(3);% width of the rectangle
h = initstate(4);% height of the rectangle
%---------------------------
img_dir(1).name
img = imread(img_dir(1).name);
if length(size(img))==3
    img = rgb2gray(img);
end
img = double(img);
%% 
trparams.init_negnumtrain = 50;%number of trained negative samples
trparams.init_postrainrad = 4;%radical scope of positive samples
trparams.initstate = initstate;% object position [x y width height]
trparams.srchwinsz = 25;% size of search window
%-------------------------
%% Classifier parameters
clfparams.width = trparams.initstate(3);
clfparams.height= trparams.initstate(4);
% feature parameters
% number of rectangle from 2 to 4.
ftrparams.minNumRect =2;
ftrparams.maxNumRect =4;
M = 100;% number of all weaker classifiers, i.e,feature pool
%-------------------------
posx.mu = zeros(M,1);% mean of positive features
negx.mu = zeros(M,1);
posx.sig= ones(M,1);% variance of positive features
negx.sig= ones(M,1);

lRate = 0.85;% Learning rate parameter
%% Compute feature template
[ftr.px,ftr.py,ftr.pw,ftr.ph,ftr.pwt] = HaarFtr(clfparams,ftrparams,M);
%% Compute sample templates
posx.sampleImage = sampleImgDet(img,initstate,trparams.init_postrainrad,1);
negx.sampleImage = sampleImg(img,initstate,1.5*trparams.srchwinsz,4+trparams.init_postrainrad,trparams.init_negnumtrain);
%% Feature extraction
iH = integral(img);%Compute integral image
posx.feature = getFtrVal(iH,posx.sampleImage,ftr);
negx.feature = getFtrVal(iH,negx.sampleImage,ftr);
[posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);% update distribution parameters
%% Begin tracking
for i = 2:num
    img = imread(img_dir(i).name);
    imgSr = img;% imgSr is used for showing tracking results.
  
    if length(size(img))==3
    img = rgb2gray(img);
    end    
    img = double(img); 
    iH = integral(img);%Compute integral image
   
    %% Coarse detection
    step = 4; % coarse search step
    detectx.sampleImage = sampleImgDet(img,initstate,trparams.srchwinsz,step);    
    detectx.feature = getFtrVal(iH,detectx.sampleImage,ftr);
    r = ratioClassifier(posx,negx,detectx.feature);% compute the classifier for all samples
    clf = sum(r);% linearly combine the ratio classifiers in r to the final classifier
    [~,index] = max(clf);
    x = detectx.sampleImage.sx(index);
    y = detectx.sampleImage.sy(index);
    w = detectx.sampleImage.sw(index);
    h = detectx.sampleImage.sh(index);
    initstate = [x y w h];
    %% Fine detection
    step = 1;
    detectx.sampleImage = sampleImgDet(img,initstate,10,step);    
    detectx.feature = getFtrVal(iH,detectx.sampleImage,ftr);
    r = ratioClassifier(posx,negx,detectx.feature);% compute the classifier for all samples
    clf = sum(r);% linearly combine the ratio classifiers in r to the final classifier
    [c,index] = max(clf);
    x = detectx.sampleImage.sx(index);
    y = detectx.sampleImage.sy(index);
    w = detectx.sampleImage.sw(index);
    h = detectx.sampleImage.sh(index);
    initstate = [x y w h];
    %% Show the tracking results
    imshow(uint8(imgSr));
    rectangle('Position',initstate,'LineWidth',4,'EdgeColor','r');
    hold on;
    text(5, 18, strcat('#',num2str(i)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
    set(gca,'position',[0 0 1 1]); 
    pause(0.00001); 
    hold off;
    %% Extract samples 
    posx.sampleImage = sampleImgDet(img,initstate,trparams.init_postrainrad,1);
    negx.sampleImage = sampleImg(img,initstate,1.5*trparams.srchwinsz,4+trparams.init_postrainrad,trparams.init_negnumtrain);
    %% Update all the features
    posx.feature = getFtrVal(iH,posx.sampleImage,ftr);
    negx.feature = getFtrVal(iH,negx.sampleImage,ftr); 
    [posx.mu,posx.sig,negx.mu,negx.sig] = classiferUpdate(posx,negx,posx.mu,posx.sig,negx.mu,negx.sig,lRate);% update distribution parameters  
end
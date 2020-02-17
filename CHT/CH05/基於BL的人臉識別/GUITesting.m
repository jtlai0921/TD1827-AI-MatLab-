function [name] = GUITesting(Iminput,BLS_model,names)
%%
% load BLS_model
% load names

%%
% I = imread('.\testdata\Jiang_Zemin\Jiang_Zemin_0010.jpg');  
% I = imread('.\testdata\Angelina_Jolie\Angelina_Jolie_0013.jpg');  
% I = imread('.\testdata\Paul_Bremer\Paul_Bremer_0020.jpg');  
% I = imread('.\testdata\Michael_Bloomberg\Michael_Bloomberg_0020.jpg');  
% I = imread('.\testdata\Igor_Ivanov\Igor_Ivanov_0020.jpg'); 
% BLS_model=load('BLS_model.mat');
% names=load('names.mat');
% GUITesting(I,BLS_model,names)

I = rgb2gray(Iminput);
I = imresize(I, 0.24);
I = reshape(I,1,60*60);

%%
test_x = I;
test_x = double(test_x/255);
[Test_x] = pre_zca(test_x);
test_x = Test_x;

%%
test_x = zscore(test_x')';
HH1 = [test_x .1 * ones(size(test_x,1),1)];

yy1=zeros(size(test_x,1),BLS_model.N2*BLS_model.N1);
for i=1:BLS_model.N2
    beta1=BLS_model.beta11{i};ps1=BLS_model.ps(i);
    TT1 = HH1 * beta1;
    TT1  =  mapminmax('apply',TT1',ps1)';
    clear beta1; clear ps1;
    yy1(:,BLS_model.N1*(i-1)+1:BLS_model.N1*i)=TT1;
end
clear TT1;clear HH1;
HH2 = [yy1 .1 * ones(size(yy1,1),1)]; 
TT2 = tansig(HH2 * BLS_model.wh * BLS_model.l2);TT3=[yy1 TT2];
clear HH2;clear wh;clear TT2;

%% predict
x = TT3 * BLS_model.beta;
y = result(x);

%%
name=strrep(names.nameFolds{y},'_',' ');
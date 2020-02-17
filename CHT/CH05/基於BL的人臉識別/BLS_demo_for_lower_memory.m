%%%%%%%%%%%%%%%%%%%%%%%%This is the demo for the bls models including the
%%%%%%%%%%%%%%%%%%%%%%%%proposed incremental learning algorithms when the
%%%%%%%%%%%%%%%%%%%%%%%%memory of PC is not sufficient%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%load the dataset norb dataset%%%%%%%%%%%%%%%%%%%%
function [] = BLS_demo_for_lower_memory()
warning off all;
format compact;
load facedb;

%%%%%%%%%%%%%%%the samples from the data are normalized and the lable data
%%%%%%%%%%%%%%%train_y and test_y are reset as N*C matrices%%%%%%%%%%%%%%
train_x = double(train_x/255);
train_y = double(train_y);
train_y = (train_y-1)*2+1;
assert(isfloat(train_x), 'train_x must be a float');
assert(all(train_x(:)>=0) && all(train_x(:)<=1), 'all data in train_x must be in [0:1]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%The preprossing for the norb data: ZCA whiten%%%%%%%
[Train_x]=pre_zca(train_x);
train_x=Train_x;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%This is the model of broad learning sytem with%%%%%%
%%%%%%%%%%%%%%%%%%%%one shot structrue%%%%%%%%%%%%%%%%%%%%%%%%
C = 2^-30; s = .8;%the l2 regularization parameter and the shrinkage scale of the enhancement nodes
N11=100;%feature nodes  per window
N2=10;% number of windows of feature nodes
N33=1000;% number of enhancement nodes
epochs=1;% number of epochs 
train_err=zeros(1,epochs);test_err=zeros(1,epochs);
train_time=zeros(1,epochs);test_time=zeros(1,epochs);
N1=N11; N3=N33;  
for j=1:epochs    
    [beta,beta11,ps,wh,l2] = bls_train(train_x,train_y,s,C,N1,N2,N3);       
end

save BLS_model beta beta11 ps wh l2 N1 N2 N3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


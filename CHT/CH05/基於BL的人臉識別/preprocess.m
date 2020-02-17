%%
function [] = preprocess()
%%
d = dir('traindata');
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
%%
[M]=size(nameFolds,1);

%%
train_x = zeros(20*M,60*60);
train_y = zeros(20*M,M);

% test_x = zeros(1*M,60*60);
% test_y = zeros(1*M,M);

%%
index=0;
for i=1:M    
    d=[pwd '\traindata\' nameFolds{i}];
    files = dir(fullfile(d, '\*.jpg'));
    for j=1:size(files,1)
        index = index+1;
        filename=[d '\' files(j).name];
        I = rgb2gray(imread(filename));
        I = imresize(I, 0.24);
        I = reshape(I,1,60*60);        
        train_x(index,:) = I;
        train_y(index,i) = 1;
    end
end
% index=0;
% for i=1:M    
%     d=[pwd '\testdata\' nameFolds{i}];
%     files = dir(fullfile(d, '\*.jpg'));
%     for j=1:size(files,1)
%         index = index+1;
%         filename=[d '\' files(j).name];
%         I = rgb2gray(imread(filename));
%         I = imresize(I, 0.24);
%         I = reshape(I,1,60*60);
%         test_x(index,:) = I;
%         test_y(index,i) = 1;
%     end
% end
%%
% save facedb train_x train_y test_x test_y
save facedb train_x train_y
save names nameFolds
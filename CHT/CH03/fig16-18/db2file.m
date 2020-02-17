clc; clear all; close all;
load(fullfile(pwd, 'database', 'AR_database.mat'))
for i = 1 : size(Tr_dataMatrix, 2)
    image_i = reshape(Tr_dataMatrix(:,i),[165 120]);
    class_i = Tr_sampleLabels(1, i);
    foldername_out = fullfile(pwd, 'r', sprintf('%d', class_i));
    if ~exist(foldername_out, 'dir')
        mkdir(foldername_out);
    end
    for j = 1 : 700
        filename = fullfile(foldername_out, sprintf('%03d.jpg', j));
        if ~exist(filename, 'file')
            imwrite(image_i, filename);
            break;
        end
    end
end

for i = 1 : size(Tt_dataMatrix, 2)
    image_i = reshape(Tt_dataMatrix(:,i),[165 120]);
    class_i = Tt_sampleLabels(1, i);
    foldername_out = fullfile(pwd, 't', sprintf('%d', class_i));
    if ~exist(foldername_out, 'dir')
        mkdir(foldername_out);
    end
    for j = 1 : 700
        filename = fullfile(foldername_out, sprintf('%03d.jpg', j));
        if ~exist(filename, 'file')
            imwrite(image_i, filename);
            break;
        end
    end
end
% 顯示關鍵點
function disp_haar_like_feature(image, locs)
% 顯示視窗
figure('Position', [50 50 size(image,2) size(image,1)]);
% 色彩型態
colormap('gray');
% 顯示
imagesc(image);
hold on;
% 角度變數
t = linspace(0, 2*pi);
for i = 1: size(locs{1},1)
    % 產生位置x
    xt = locs{1}(1) + locs{1}(3)*cos(t);
    % 產生位置y
    yt = locs{1}(2) + locs{1}(3)*sin(t);
    % 顯示
    plot(xt, yt, 'r:', 'LineWidth', 2);
end
% 繪制特征點
plot(locs{2}(:,1), locs{2}(:,2), 'r*');
hold off;
% ��������I
function disp_haar_like_feature(image, locs)
% ��ܵ���
figure('Position', [50 50 size(image,2) size(image,1)]);
% ��m���A
colormap('gray');
% ���
imagesc(image);
hold on;
% �����ܼ�
t = linspace(0, 2*pi);
for i = 1: size(locs{1},1)
    % ���ͦ�mx
    xt = locs{1}(1) + locs{1}(3)*cos(t);
    % ���ͦ�my
    yt = locs{1}(2) + locs{1}(3)*sin(t);
    % ���
    plot(xt, yt, 'r:', 'LineWidth', 2);
end
% ø��S���I
plot(locs{2}(:,1), locs{2}(:,2), 'r*');
hold off;
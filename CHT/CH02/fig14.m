%建立座標系
axis([0 15 0 15]);
hold on %保持工作狀態
%起始化
x=[];y=[];m=0;
%設定提示語，說明選點模式
disp('請點選滑鼠左鍵，點取您需要的點');
disp('請點選滑鼠右鍵，點取最後一個點');
%實現滑鼠選點
but=1;while but==1
[xi,yi,but]=ginput(1); plot(xi,yi,'ko');%把滑鼠選點結果標示出來
m=m+1;%可以無限次重復選點
%補充提示語，說明如何終止選點
disp('點選滑鼠左鍵點取下一個點');
x(m,1)=xi; y(m,1)=yi; %將所有點的橫、垂直座標整合為向量
end
%選點完成了，開始連線
t=1:m;%選點的數量
ts=1:0.15:m;%界定插值間隔
xs=spline(t,x,ts);ys=spline(t,y,ts);%橫、垂直座標插值
plot(xs,ys,'y-'); %連線
hold off %終止工作,因為開始用了hold on，就需要用hold on終止

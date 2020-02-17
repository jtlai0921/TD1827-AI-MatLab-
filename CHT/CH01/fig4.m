a= im2bw(imread('1.jpg')); %輸入二值圖形 
b=[0 1 0;1 1 1;0 1 0];  %參數設定
c=imdilate(a,b);%膨脹動作
imshow(c)%顯示執行結果

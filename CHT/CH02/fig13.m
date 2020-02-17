%參數設定；如下是假設的數值，讀者可根據實際情況修改
m=150;
n=160;
x=0.3;
y=0.7; 
%（1）設定人臉圖形大小
rows = m; 
cols = n;
%（2）定義特征點位置的比例系數
rowFrac = x; colFrac = y;
%（3）根據對稱性，產生並整合特征點座標 
le=[(1-colFrac)*cols,rows*rowFrac]; %左眼的座標
re=[colFrac*cols,rows*rowFrac]; %右眼的座標
mouth=[0.5*cols,rows*(1-rowFrac),]; %嘴巴的座標
landmark_tool=[le;re;mouth];%整合三個特征點的座標

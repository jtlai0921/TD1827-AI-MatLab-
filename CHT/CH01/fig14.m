clc;
clear all;
close all;
x=imread('1.jpg');
y=rgb2ycbcr(x); %將彩色圖片從RGB空間轉換到YCbCr色彩空間
[a b c]=size(y); %取得圖形的行數、列數、頁數；注意新空間裡圖形是3D陣列
cb=double(y(:,:,2)); %得到圖形的Cb分量
cr=double(y(:,:,3)); %得到圖形的Cr分量
%下面開始計算每個像素點的膚色機率
for i=1:a;
    for j=1:b
        w=[cb(i,j) cr(i,j)]; %色度矩陣
        m=[110.4516 150.5699]; %膚色均值，可以瞭解為離散高斯分佈的期望值，這個均值需要提前確定，這個是膚色機率模型的明顯不足之處；大家換圖片測試，會發現可能需要修改此參數
        n=[97.0916 23.3700;23.3700 137.9966]; %協方差矩陣，對應此處離散高斯分佈
        p(i,j)=exp((-0.5)*(w-m)*inv(n)*(w-m)'); %計算膚色機率，即相似度
        end
end
z=p./max(max(p));%歸一化結果
%下面開始設定值化
%figure
th=0.5;
for i=1:a
    for j=1:b
        if(z(i,j)>th) 
            z(i,j)=1;
        else
            z(i,j)=0;
        end
    end
end
figure;%%開始一邊處理一邊出圖了！
subplot(2,2,1);
imshow(z);
title('Set threshold') %設定值化結果
%下面做數學形態學處理，先後進行了開運算、閉運算、填洞、腐蝕及膨脹動作
se=strel('square',3);
	f=imopen(z,se); %開運算
    f=imclose(f,se); %閉運算
		f=imfill(f,'holes');%填洞
   	se1=strel('square',8); 
%建構結構元素（strel是Structuring element的簡寫）
	f=imerode(f,se1); %腐蝕
	f=imdilate(f,se1); %膨脹
	%至此得到了一個較純淨的膚色區域
%下面試圖將人臉區域與其它膚色區域分割開
 [L,num]=bwlabel(f,4); 
%傳回一個和f大小相同的L矩陣,包括標示了f中每個連通區域的類別別標簽,這些標簽的值為1、2、num(連通區域的個數)
	for i=1:num;
	    [r,c]=find(L==i);%第i個連通區域
        len=max(r)-min(r)+1;%區域長度
        wid=max(c)-min(c)+1;%區域寬度
                area_sq=len*wid;%區域面積
        area=size(r,1);%區域大小，即像素點的個數
        %開始判定第i個連通區域是不是人臉區域
        for j=1:size(r,1)
            if(len/wid<.8)|(len/wid>2.4)|size(r,1)<200|area/area_sq<0.55
                L(r(j),c(j))=0;%若果不是人臉區域，則透過給予值將其融入背景色
            else
                continue;
            end
        end
    end
    subplot(2,2,2);
imshow(L);
title('Face Region')%人臉區域顯示
    w=L&z;
%透過邏輯運算，檢驗面部特征點；程式碼開始設定的膚色均值，顯然也會影響這個特征點的檢驗，大家從程式執行結果中也不難看出；請大家試著調整膚色均值，看看執行結果的變化
    subplot(2,2,3);
imshow(w);
title('Features points')%人臉特征點顯示
%開始標示人臉區域，這裡用矩形標示，讀者也可以嘗試用
    [r c]=find(L~=0);
    r_min=min(r);
r_max=max(r);
    c_min=min(c);
c_max=max(c);
    subplot(2,2,4);
imshow(x); 
title('Detection result')
    rectangle('Position',[c_min r_min c_max-c_min r_max-r_min],'EdgeColor','r');
%以矩形區域為人臉檢驗的結果
clc;
clear all;
close all;
x=imread('1.jpg');
y=rgb2ycbcr(x); %�N�m��Ϥ��qRGB�Ŷ��ഫ��YCbCr��m�Ŷ�
[a b c]=size(y); %���o�ϧΪ���ơB�C�ơB���ơF�`�N�s�Ŷ��̹ϧάO3D�}�C
cb=double(y(:,:,2)); %�o��ϧΪ�Cb���q
cr=double(y(:,:,3)); %�o��ϧΪ�Cr���q
%�U���}�l�p��C�ӹ����I��������v
for i=1:a;
    for j=1:b
        w=[cb(i,j) cr(i,j)]; %��ׯx�}
        m=[110.4516 150.5699]; %���⧡�ȡA�i�H�A�Ѭ������������G������ȡA�o�ӧ��Ȼݭn���e�T�w�A�o�ӬO������v�ҫ������㤣�����B�F�j�a���Ϥ����աA�|�o�{�i��ݭn�ק惡�Ѽ�
        n=[97.0916 23.3700;23.3700 137.9966]; %���t�x�}�A�������B�����������G
        p(i,j)=exp((-0.5)*(w-m)*inv(n)*(w-m)'); %�p�⽧����v�A�Y�ۦ���
        end
end
z=p./max(max(p));%�k�@�Ƶ��G
%�U���}�l�]�w�Ȥ�
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
figure;%%�}�l�@��B�z�@��X�ϤF�I
subplot(2,2,1);
imshow(z);
title('Set threshold') %�]�w�ȤƵ��G
%�U�����ƾǧκA�ǳB�z�A����i��F�}�B��B���B��B��}�B�G�k�ο��Ȱʧ@
se=strel('square',3);
	f=imopen(z,se); %�}�B��
    f=imclose(f,se); %���B��
		f=imfill(f,'holes');%��}
   	se1=strel('square',8); 
%�غc���c�����]strel�OStructuring element��²�g�^
	f=imerode(f,se1); %�G�k
	f=imdilate(f,se1); %����
	%�ܦ��o��F�@�Ӹ��²b������ϰ�
%�U���չϱN�H�y�ϰ�P�䥦����ϰ���ζ}
 [L,num]=bwlabel(f,4); 
%�Ǧ^�@�өMf�j�p�ۦP��L�x�},�]�A�ХܤFf���C�ӳs�q�ϰ쪺���O�O��ñ,�o�Ǽ�ñ���Ȭ�1�B2�Bnum(�s�q�ϰ쪺�Ӽ�)
	for i=1:num;
	    [r,c]=find(L==i);%��i�ӳs�q�ϰ�
        len=max(r)-min(r)+1;%�ϰ����
        wid=max(c)-min(c)+1;%�ϰ�e��
                area_sq=len*wid;%�ϰ쭱�n
        area=size(r,1);%�ϰ�j�p�A�Y�����I���Ӽ�
        %�}�l�P�w��i�ӳs�q�ϰ�O���O�H�y�ϰ�
        for j=1:size(r,1)
            if(len/wid<.8)|(len/wid>2.4)|size(r,1)<200|area/area_sq<0.55
                L(r(j),c(j))=0;%�Y�G���O�H�y�ϰ�A�h�z�L�����ȱN��ĤJ�I����
            else
                continue;
            end
        end
    end
    subplot(2,2,2);
imshow(L);
title('Face Region')%�H�y�ϰ����
    w=L&z;
%�z�L�޿�B��A���筱���S���I�F�{���X�}�l�]�w�����⧡�ȡA��M�]�|�v�T�o�ӯS���I������A�j�a�q�{�����浲�G���]�����ݥX�F�Фj�a�յ۽վ㽧�⧡�ȡA�ݬݰ��浲�G���ܤ�
    subplot(2,2,3);
imshow(w);
title('Features points')%�H�y�S���I���
%�}�l�ХܤH�y�ϰ�A�o�̥ίx�μХܡAŪ�̤]�i�H���ե�
    [r c]=find(L~=0);
    r_min=min(r);
r_max=max(r);
    c_min=min(c);
c_max=max(c);
    subplot(2,2,4);
imshow(x); 
title('Detection result')
    rectangle('Position',[c_min r_min c_max-c_min r_max-r_min],'EdgeColor','r');
%�H�x�ΰϰ쬰�H�y���窺���G
function [boxs,face_num,duration]=face_detect(image,threshold,min_size)
    if isempty(image)
        boxs=[];
        face_num=0;
        duration=0;
        return ;
    end 

    if (nargin==1)
        threshold =0.5;
        min_size=40;
    elseif (nargin==2)
        min_size=40;
    end

    %fprintf('%f %d\r\n',threshold,min_size);
    min_area=min_size*min_size;
    tic;
    YCbCr=rgb2ycbcr(image);
    [height width channel]=size(YCbCr);
    cb=double(YCbCr(:,:,2));
    cr=double(YCbCr(:,:,3));
    Ecb = (cb-117.4316);
    Ecr = (cr-148.5599);
    prob=exp((-0.0019)*Ecb.^2+(0.0004)*(Ecb).*(Ecr)+(-0.0033)*Ecr.^2);
    z=prob./max(max(prob));%---------------------------------------------------------complextion probability
    z = im2bw(z,threshold);
    %figure;imshow(z);title('Set threshold')%-----------------------------------threshold
    se=strel('square',3);
    f=imopen(z,se);
    f=imclose(f,se);
    %figure,imshow(f);%open and close processing;
    f=imfill(f,'holes');
    %figure,imshow(f);%fill holes in the Img
    se1=strel('square',4);
    f=imerode(f,se1);
    f=imdilate(f,se1);
    %figure,imshow(f);%----------------------------------------------------erosion and expansion;
    [L,num]=bwlabel(f,4);

    for i=1:num;%region loop;
        [r,c]=find(L==i);
        len=max(r)-min(r)+1;
        wid=max(c)-min(c)+1;

        area_sq=len*wid;
        area=size(r,1);
        len_wid_ratio=len/wid;
        area_sq_ratio =area/area_sq;

       for j=1:size(r,1)%pixel loop;
            if(len_wid_ratio<.8)|(len_wid_ratio>2.4)|area<(min_area)|area_sq_ratio<0.65
                L(r(j),c(j))=0;%not zero pixel =0;
            else
                continue;
            end
        end
    end

    w=L&z;

    [L,num]=bwlabel(w,4);
    if num>0 
         boxs=zeros(num,4);
         face_num=num;
        for i=1:num
            [r c]=find(L==i);
            r_min=min(r);r_max=max(r);
            c_min=min(c);c_max=max(c);
            boxs(i,1)=c_min;%x1
            boxs(i,2)=r_min;%y1
            boxs(i,3)=c_max;%x2
            boxs(i,4)=r_max;%y2
        end
    else
        boxs=[];
        face_num=0;
    end
 duration=toc; 
 end
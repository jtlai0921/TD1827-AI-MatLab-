%�إ߮y�Шt
axis([0 15 0 15]);
hold on %�O���u�@���A
%�_�l��
x=[];y=[];m=0;
%�]�w���ܻy�A�������I�Ҧ�
disp('���I��ƹ�����A�I���z�ݭn���I');
disp('���I��ƹ��k��A�I���̫�@���I');
%��{�ƹ����I
but=1;while but==1
[xi,yi,but]=ginput(1); plot(xi,yi,'ko');%��ƹ����I���G�ХܥX��
m=m+1;%�i�H�L�������_���I
%�ɥR���ܻy�A�����p��פ���I
disp('�I��ƹ������I���U�@���I');
x(m,1)=xi; y(m,1)=yi; %�N�Ҧ��I����B�����y�о�X���V�q
end
%���I�����F�A�}�l�s�u
t=1:m;%���I���ƶq
ts=1:0.15:m;%�ɩw���ȶ��j
xs=spline(t,x,ts);ys=spline(t,y,ts);%��B�����y�д���
plot(xs,ys,'y-'); %�s�u
hold off %�פ�u�@,�]���}�l�ΤFhold on�A�N�ݭn��hold on�פ�

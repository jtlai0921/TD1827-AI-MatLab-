%�ѼƳ]�w�F�p�U�O���]���ƭȡAŪ�̥i�ھڹ�ڱ��p�ק�
m=150;
n=160;
x=0.3;
y=0.7; 
%�]1�^�]�w�H�y�ϧΤj�p
rows = m; 
cols = n;
%�]2�^�w�q�S���I��m����Ҩt��
rowFrac = x; colFrac = y;
%�]3�^�ھڹ�٩ʡA���ͨþ�X�S���I�y�� 
le=[(1-colFrac)*cols,rows*rowFrac]; %�������y��
re=[colFrac*cols,rows*rowFrac]; %�k�����y��
mouth=[0.5*cols,rows*(1-rowFrac),]; %�L�ڪ��y��
landmark_tool=[le;re;mouth];%��X�T�ӯS���I���y��

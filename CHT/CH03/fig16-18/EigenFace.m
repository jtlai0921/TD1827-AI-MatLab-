function [disc_set,disc_value, mean_image] = EigenFace(ro_data, ro_num)
% ­pºâ¯S©ºÁy
[face_vector_length, faces_number] = size(ro_data);
if face_vector_length <= faces_number
    mean_image = mean(ro_data, 2);
    ro_data = ro_data-mean_image*ones(1,faces_number);
    rm = ro_data*ro_data'/(faces_number-1);
    [Eigen_Vector, Eigen_Value] = Find_K_Max_Eigen(rm,ro_num);
    disc_value = Eigen_Value;
    disc_set = Eigen_Vector;
else
    mean_image = mean(ro_data,2);
    ro_data = ro_data-mean_image*ones(1,faces_number);
    rm = ro_data'*ro_data/(faces_number-1);
    [Eigen_Vector, Eigen_Value] = Find_K_Max_Eigen(rm, ro_num);
    disc_value = Eigen_Value;
    disc_set = zeros(face_vector_length,ro_num);
    ro_data = ro_data/sqrt(faces_number-1);
    for k = 1:ro_num
        disc_set(:,k) = (1/sqrt(disc_value(k)))*ro_data*Eigen_Vector(:,k);
    end
end

function [Eigen_Vector, Eigen_Value] = Find_K_Max_Eigen(rm, rm_num)
[rs, ~] = size(rm);
[V,S] = eig(rm);
S = diag(S);
[S,index] = sort(S);
Eigen_Vector = zeros(rs,rm_num);
Eigen_Value = zeros(1,rm_num);
p=rs;
for t=1:rm_num
    Eigen_Vector(:,t) = V(:,index(p));
    Eigen_Value(t) = S(p);
    p = p-1;
end
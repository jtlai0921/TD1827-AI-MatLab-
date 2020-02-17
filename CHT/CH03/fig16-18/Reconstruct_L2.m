function [origin_image, result_image] = Reconstruct_L2(input_file)
% 取得資料庫資料
[r_data, r_label] = Init_Db();
% 資料預先處理
[ro_data, rt_data, ru_label] = Data_PreProcess(r_data, r_label, input_file);
% 取得目前分類別數
class_num = max(r_label(:));
% 降取樣參數
im_h = 84;
im_w = 60;
% 起始化資料
ro_data_double = double(ro_data);
ro_num_double = 260;
rt_data_double = double(rt_data);
ru_label_double = double(ru_label);
% 計算特征臉
th = 0.001;
[disc_set,disc_value,Mean_Image] = EigenFace(ro_data_double, ro_num_double);
disc_value = sqrt((disc_value));
mean_x = (Mean_Image+th*disc_set*disc_value');
% 設定算法參數
iter_number = 30;
beta_init = 8;
median_init = 0.6;
ro_data_double = ro_data_double./ repmat(sqrt(sum(ro_data_double.*ro_data_double)),[size(ro_data_double,1) 1]);
beta_once = beta_init(1);
median_once = median_init(1);
eye_matrix = eye(size(ro_data_double,2));
lambda_once = 0.001;
weight_thresh = 5e-2;
weight_gap = [];
% 迭代
for li = 1:size(lambda_once,2)
    now_lambda = lambda_once(li);
    ids = [];
    % 迭代不同的輸入資料
    for pro_i = 1:size(rt_data_double,2)
        y = double(rt_data_double(:,pro_i));
        % RRC_L2
        residual = (y-mean_x).^2;
        residual_sort = sort(residual);
        iter = residual_sort(ceil(median_once*length(residual))); beta = beta_once/iter;
        w = 1./(1+1./exp(-beta*(residual-iter)));
        weight_pref = w;
        norm_y_D = norm(y);
        y = y./norm(y);
        % 迭代計算
        for nit = 1: iter_number
            tem_w = w./max(w);
            index_w = find(tem_w>1e-3);
            % 移除過小像素點
            w_y = w(index_w).*y(index_w);
            w_d = repmat(w(index_w),[1 size(ro_data_double,2)]).*ro_data_double(index_w,:);
            temp_s = (w_d'*w_d+now_lambda*norm(w_y)*eye_matrix)\(w_d'*w_y);
            residual = norm_y_D^2.*(y-ro_data_double*temp_s).^2;
            residual_sort = sort(residual);
            iter = residual_sort(ceil(median_once*length(residual))); beta = beta_once/iter;
            w = 1./(1+1./exp(-beta*(residual-iter)));
            weight_g = norm(w-weight_pref,2)/norm(weight_pref,2);
            weight_pref = w;
            weight_gap = [weight_gap weight_g];
            if weight_g < weight_thresh
                % 停止迭代
                break;
            end
        end
        % 分類別計算
        for class = 1:class_num
            s = temp_s (ru_label_double == class);
            z1 = w.*(y - ro_data_double(:,ru_label_double == class)*s);
            gap1(class) = z1(:)'*z1(:);
        end
        % 分類別判別
        index = find(gap1==min(gap1));
        ids = [ids index(1)];
        %計算重構圖形
        s = temp_s (ru_label_double == index);
        [max_s, ind_max_s] = max(s);
        t = ro_data_double(:,ru_label_double == index);
        y_rec = t(:,ind_max_s)*max_s;
        % 輸出結果
        origin_image = reshape(uint8(y*norm_y_D),im_h,im_w);
        result_image = reshape(uint8(y_rec*norm_y_D),im_h,im_w);
    end
end
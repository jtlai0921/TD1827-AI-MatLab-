top_folder =  'C:\Users\wwf\Desktop\第4章/wyb'; % 第一層資料夾名稱
mkdir(top_folder); % 建立第一層資料夾
second_folder = sprintf('%s/%s', top_folder, 'images'); % 建構第二層資料夾名稱
mkdir(second_folder); % 建立第二層資料夾
third_folder = sprintf('%s/%s', second_folder, '20180105'); % 建構第三層資料夾名稱
mkdir(third_folder); % 建立第三層資料夾 
%想建立第四層、第五層資料夾？沒問題，依此類推即可。
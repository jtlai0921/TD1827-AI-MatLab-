clc;
%%第一層資料夾存在與否判定及建立
if ~exist('C:\Users\wwf\Desktop\第4章/wyb');
top_folder =  'C:\Users\wwf\Desktop\第4章/wyb'; % 第一層資料夾名稱
mkdir(top_folder); % 建立第一層資料夾
end

%%第二層資料夾存在與否判定及建立
if ~exist('C:\Users\wwf\Desktop\第4章\wyb/images');
second_folder = sprintf('%s/%s',top_folder,'images'); %建構第二層資料夾名稱
mkdir(second_folder); % 建立第二層資料夾
end

%%第三層資料夾存在與否判定及建立
if ~exist('C:\Users\wwf\Desktop\第4章\wyb\images/20180106');
third_folder = sprintf('%s/%s', second_folder, '20180106'); % 建構第三層資料夾名稱(每次都是最後一層建構的資料夾名稱前用斜槓，其它都是反斜槓)。
mkdir(third_folder); % 建立第三層資料夾 
end
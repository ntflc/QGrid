% 此函数用于统计某一时间段不同网格内的车辆数
function [row_num, col_num, grid_num, grid_list] = GridCountStatistics()

% 导入第2步得到的区域范围内的GPS数据
load('taxi20070201.mat');
load('taxi20070202.mat');
load('taxi20070203.mat');
load('taxi20070204.mat');
load('taxi20070205.mat');
load('taxi20070206.mat');
load('taxi20070207.mat');
load('taxi20070208.mat');
load('taxi20070209.mat');

% 定义区域中心
region_x = 1211313.0;
region_y = 3482427.0;
% 定义区域范围
length = 1500.0;
x_min = region_x - length;
x_max = region_x + length;
y_min = region_y - length;
y_max = region_y + length;
% 定义基本参数
grid_length = 500;                              % 网格边长
row_num = ceil((x_max - x_min) / grid_length);	% 网格行数=6
col_num = ceil((y_max - y_min) / grid_length);	% 网格列数=6
grid_num = row_num * col_num;                   % 网格数=36

% 将GPS数据按时间片进行划分，以便后面选择指定时间段内的数据
delta_t = 3600; % 这里选择Δt=1小时
taxi20070201(:, 5) = floor(taxi20070201(:, 5) / delta_t);
taxi20070202(:, 5) = floor(taxi20070202(:, 5) / delta_t);
taxi20070203(:, 5) = floor(taxi20070203(:, 5) / delta_t);
taxi20070204(:, 5) = floor(taxi20070204(:, 5) / delta_t);
taxi20070205(:, 5) = floor(taxi20070205(:, 5) / delta_t);
taxi20070206(:, 5) = floor(taxi20070206(:, 5) / delta_t);
taxi20070207(:, 5) = floor(taxi20070207(:, 5) / delta_t);
taxi20070208(:, 5) = floor(taxi20070208(:, 5) / delta_t);
taxi20070209(:, 5) = floor(taxi20070209(:, 5) / delta_t);

% 选出指定时间段内的GPS数据
t_start = 10;   % 起始时间为10点
t_end = 11;     % 终止时间为11点
taxi20070201 = taxi20070201(taxi20070201(:, 5) >= t_start & taxi20070201(:, 5) < t_end, :);
taxi20070202 = taxi20070202(taxi20070202(:, 5) >= t_start & taxi20070202(:, 5) < t_end, :);
taxi20070203 = taxi20070203(taxi20070203(:, 5) >= t_start & taxi20070203(:, 5) < t_end, :);
taxi20070204 = taxi20070204(taxi20070204(:, 5) >= t_start & taxi20070204(:, 5) < t_end, :);
taxi20070205 = taxi20070205(taxi20070205(:, 5) >= t_start & taxi20070205(:, 5) < t_end, :);
taxi20070206 = taxi20070206(taxi20070206(:, 5) >= t_start & taxi20070206(:, 5) < t_end, :);
taxi20070207 = taxi20070207(taxi20070207(:, 5) >= t_start & taxi20070207(:, 5) < t_end, :);
taxi20070208 = taxi20070208(taxi20070208(:, 5) >= t_start & taxi20070208(:, 5) < t_end, :);
taxi20070209 = taxi20070209(taxi20070209(:, 5) >= t_start & taxi20070209(:, 5) < t_end, :);

% 统计每天每个网格的GPS数据，存入grid_cntn（6*6矩阵）中
% 20070201
taxi_cnt1 = size(taxi20070201, 1);
grid_cnt1 = zeros(row_num, col_num);
for i = 1:taxi_cnt1
    x = ceil((taxi20070201(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070201(i, 3) - y_min) / grid_length);
    grid_cnt1(y, x) = grid_cnt1(y, x) + 1;
end
% 20070202
taxi_cnt2 = size(taxi20070202, 1);
grid_cnt2 = zeros(row_num, col_num);
for i = 1:taxi_cnt2
    x = ceil((taxi20070202(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070202(i, 3) - y_min) / grid_length);
    grid_cnt2(y, x) = grid_cnt2(y, x) + 1;
end
% 20070203
taxi_cnt3 = size(taxi20070203, 1);
grid_cnt3 = zeros(row_num, col_num);
for i = 1:taxi_cnt3
    x = ceil((taxi20070203(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070203(i, 3) - y_min) / grid_length);
    grid_cnt3(y, x) = grid_cnt3(y, x) + 1;
end
% 20070204
taxi_cnt4 = size(taxi20070204, 1);
grid_cnt4 = zeros(row_num, col_num);
for i = 1:taxi_cnt4
    x = ceil((taxi20070204(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070204(i, 3) - y_min) / grid_length);
    grid_cnt4(y, x) = grid_cnt4(y, x) + 1;
end
% 20070205
taxi_cnt5 = size(taxi20070205, 1);
grid_cnt5 = zeros(row_num, col_num);
for i = 1:taxi_cnt5
    x = ceil((taxi20070205(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070205(i, 3) - y_min) / grid_length);
    grid_cnt5(y, x) = grid_cnt5(y, x) + 1;
end
% 20070206
taxi_cnt6 = size(taxi20070206, 1);
grid_cnt6 = zeros(row_num, col_num);
for i = 1:taxi_cnt6
    x = ceil((taxi20070206(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070206(i, 3) - y_min) / grid_length);
    grid_cnt6(y, x) = grid_cnt6(y, x) + 1;
end
% 20070207
taxi_cnt7 = size(taxi20070207, 1);
grid_cnt7 = zeros(row_num, col_num);
for i = 1:taxi_cnt7
    x = ceil((taxi20070207(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070207(i, 3) - y_min) / grid_length);
    grid_cnt7(y, x) = grid_cnt7(y, x) + 1;
end
% 20070208
taxi_cnt8 = size(taxi20070208, 1);
grid_cnt8 = zeros(row_num, col_num);
for i = 1:taxi_cnt8
    x = ceil((taxi20070208(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070208(i, 3) - y_min) / grid_length);
    grid_cnt8(y, x) = grid_cnt8(y, x) + 1;
end
% 20070209
taxi_cnt9 = size(taxi20070209, 1);
grid_cnt9 = zeros(row_num, col_num);
for i = 1:taxi_cnt9
    x = ceil((taxi20070209(i, 2) - x_min) / grid_length);
    y = ceil((taxi20070209(i, 3) - y_min) / grid_length);
    grid_cnt9(y, x) = grid_cnt9(y, x) + 1;
end

% 将grid_cntn的二维矩阵按照先行后列的顺序转成一维矩阵
grid_list1 = zeros(grid_num, 1);
grid_list2 = zeros(grid_num, 1);
grid_list3 = zeros(grid_num, 1);
grid_list4 = zeros(grid_num, 1);
grid_list5 = zeros(grid_num, 1);
grid_list6 = zeros(grid_num, 1);
grid_list7 = zeros(grid_num, 1);
grid_list8 = zeros(grid_num, 1);
grid_list9 = zeros(grid_num, 1);
for i = 1:row_num
    for j = 1:col_num
        id = (j - 1) * row_num + i;
        grid_list1(id) = grid_cnt1(i, j);
        grid_list2(id) = grid_cnt2(i, j);
        grid_list3(id) = grid_cnt3(i, j);
        grid_list4(id) = grid_cnt4(i, j);
        grid_list5(id) = grid_cnt5(i, j);
        grid_list6(id) = grid_cnt6(i, j);
        grid_list7(id) = grid_cnt7(i, j);
        grid_list8(id) = grid_cnt8(i, j);
        grid_list9(id) = grid_cnt9(i, j);
    end
end
grid_list = [grid_list1 grid_list2 grid_list3 grid_list4 grid_list5 grid_list6 grid_list7 grid_list8 grid_list9];
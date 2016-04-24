
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

% 定义区域范围
region_x = 1211313.0;
region_y = 3482427.0;
length = 1500.0;
x_min = region_x - length;
x_max = region_x + length;
y_min = region_y - length;
y_max = region_y + length;
% 定义基本参数
grid_length = 500.0;                            % 网格边长
row_num = ceil((x_max - x_min) / grid_length);  % 网格行数=6
col_num = ceil((y_max - y_min) / grid_length);  % 网格列数=6
grid_num = row_num * col_num;                   % 网格数=36

% 初始化table表，table表标识网格之间的关系，四列分别为上一个网格、当前网格、下一个网格、0
[table] = CalculateNeighborGrid(row_num, col_num);

% 为每条数据加上所在网格的编号
% 20070201
for i = 1:size(taxi20070201, 1);
    col_x = ceil((taxi20070201(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070201(i, 3) - y_min) / grid_length);
    grid_id1(i) = (col_x - 1) * row_num + row_y;
end
taxi20070201 = [taxi20070201 grid_id1'];
% 20070202
for i = 1:size(taxi20070202, 1);
    col_x = ceil((taxi20070202(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070202(i, 3) - y_min) / grid_length);
    grid_id2(i) = (col_x - 1) * row_num + row_y;
end
taxi20070202 = [taxi20070202 grid_id2'];
% 20070203
for i = 1:size(taxi20070203, 1);
    col_x = ceil((taxi20070203(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070203(i, 3) - y_min) / grid_length);
    grid_id3(i) = (col_x - 1) * row_num + row_y;
end
taxi20070203 = [taxi20070203 grid_id3'];
% 20070204
for i = 1:size(taxi20070204, 1);
    col_x = ceil((taxi20070204(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070204(i, 3) - y_min) / grid_length);
    grid_id4(i) = (col_x - 1) * row_num + row_y;
end
taxi20070204 = [taxi20070204 grid_id4'];
% 20070205
for i = 1:size(taxi20070205, 1);
    col_x = ceil((taxi20070205(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070205(i, 3) - y_min) / grid_length);
    grid_id5(i) = (col_x - 1) * row_num + row_y;
end
taxi20070205 = [taxi20070205 grid_id5'];
% 20070206
for i = 1:size(taxi20070206, 1);
    col_x = ceil((taxi20070206(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070206(i, 3) - y_min) / grid_length);
    grid_id6(i) = (col_x - 1) * row_num + row_y;
end
taxi20070206 = [taxi20070206 grid_id6'];
% 20070207
for i = 1:size(taxi20070207, 1);
    col_x = ceil((taxi20070207(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070207(i, 3) - y_min) / grid_length);
    grid_id7(i) = (col_x - 1) * row_num + row_y;
end
taxi20070207 = [taxi20070207 grid_id7'];
% 20070208
for i = 1:size(taxi20070208, 1);
    col_x = ceil((taxi20070208(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070208(i, 3) - y_min) / grid_length);
    grid_id8(i) = (col_x - 1) * row_num + row_y;
end
taxi20070208 = [taxi20070208 grid_id8'];
% 20070209
for i = 1:size(taxi20070209, 1);
    col_x = ceil((taxi20070209(i, 2) - x_min) / grid_length);
    row_y = ceil((taxi20070209(i, 3) - y_min) / grid_length);
    grid_id9(i) = (col_x - 1) * row_num + row_y;
end
taxi20070209 = [taxi20070209 grid_id9'];

% 统计车辆在不同网格之间的转移次数
[table] = TableStatistic(taxi20070201, table);
[table] = TableStatistic(taxi20070202, table);
[table] = TableStatistic(taxi20070203, table);
[table] = TableStatistic(taxi20070204, table);
[table] = TableStatistic(taxi20070205, table);
[table] = TableStatistic(taxi20070206, table);
[table] = TableStatistic(taxi20070207, table);
[table] = TableStatistic(taxi20070208, table);
[table] = TableStatistic(taxi20070209, table);

% 保存table
save table table
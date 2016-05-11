% QGrid_G，使用贪婪选择策略

% 定义区域中心
region_x = 1211313.0;
region_y = 3482427.0;
% 定义区域范围
length = 1500.0;
x_min = region_x - length;
x_max = region_x + length;
y_min = region_y - length;
y_max = region_y + length;
% 定义网格边长
grid_length = 500;
% 定义用于存放结果的矩阵data
data = [];

% 导入数据
load('taxi20070201.mat');
% 导入Q值表
load('QTable.mat');

% 给车辆的记录加上网格信息
row_num = ceil((y_max- y_min) / grid_length);
[taxi20070201] = AddGridInfo(taxi20070201, grid_length, x_min, y_min, row_num);
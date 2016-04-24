% 将GridCountStatistics中的数据绘制成图表
% 由图标证明用过去一段时间学习得到的Q值表可以用于消息传递

% 获取GridCountStatistics中的数据，包括网格行数、列数、网格总数、GPS数量
[row_num, col_num, grid_num, grid_list] = GridCountStatistics();

% 处理数据，将GPS数量计算为GPS占比
taxi_cnt = sum(grid_list);
for i = 1:9
    grid_list(:, i) = grid_list(:, i) / taxi_cnt(1, i);
end

% 进行绘图，横轴为网格编号，纵轴为不同日期每个网格的GPS数占比
x = 1:1:grid_num;
% 20070201
y = grid_list(:, 1)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-r.');
hold on
% 20070202
y = grid_list(:, 2)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-g.');
hold on
% 20070203
y = grid_list(:, 3)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-b.');
hold on
% 20070204
y = grid_list(:, 4)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-c.');
hold on
% 20070205
y = grid_list(:, 5)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-m.');
hold on
% 20070206
y = grid_list(:, 6)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-y.');
hold on
% 20070207
y = grid_list(:, 7)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-k.');
hold on
% 20070208
y = grid_list(:, 8)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-r*');
hold on
% 20070209
y = grid_list(:, 9)';
val = spcrv([[x(1) x x(end)]; [y(1) y y(end)]], 3);
plot(val(1, :), val(2, :), '-b*');
hold on
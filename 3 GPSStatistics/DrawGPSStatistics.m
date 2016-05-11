% 将每天每个网格中的数据量占网格总数据量的比例绘制成图表
% 由图标证明用过去一段时间学习得到的Q值表可以用于消息传递

% 通过函数GridCountStatistics获取行数、列数、网格数、GPS数据
% 其中GPS数据grid_list为36行9列，表示每个网格每天的数据量
[row_num, col_num, grid_num, grid_list] = GridCountStatistics();

% 处理数据，将GPS数量计算为GPS占比
taxi_cnt = sum(grid_list);
for i = 1:days
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
% 图例信息
legend('2007年2月1日', '2007年2月2日', '2007年2月3日', '2007年2月4日', '2007年2月5日', '2007年2月6日', '2007年2月7日', '2007年2月8日', '2007年2月9日');
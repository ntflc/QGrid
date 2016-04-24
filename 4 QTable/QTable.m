
% 通过函数GridCountStatistics获取行数、列数、网格数、GPS数据
[row_num, col_num, grid_num, grid_list] = GridCountStatistics();
% 计算每个网格每天的平均数
grid_cnt = sum(grid_list, 2) / size(grid_list, 2);
% 计算网格平均数
avg = sum(grid_cnt) / grid_num;

% 通过函数RewardTable获取Reward表
[RTable] = RewardTable(row_num, col_num);

% 通过函数QLearning计算Q值表
Q = zeros(grid_num, grid_num, grid_num);
for dest_grid = 1:grid_num
    Q(:, :, dest_grid) = QLearning(RTable(:, :, dest_grid), grid_cnt, avg);
end

% 保存Q值表
save QTable Q
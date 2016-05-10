% 此函数用于Q学习算法的实现
function [QTable] = QLearning(RTable, grid_cnt, avg)

% [RTable] = RewardTable(6, 6);
% RTable = RTable(:, :, 1);
% grid_cnt = 36;
% avg = 0;

% 定义Q值表参数
alpha = 0.8;
QTable = zeros(size(RTable));

% 进行数次学习
for episode = 0:50000
    % 随机选择一个状态
    y = randperm(size(RTable, 1));      % 将网格总数随机打乱成一个矩阵
    state = y(1);                       % 取随机矩阵中的第一个值作为状态值state
    x = find(RTable(state,:) >= 0);     % 寻找state可能的下一个状态（即Reward表中第state行值大于等于0的列数）
    if size(x, 1) > 0
        x0 = RandomPermutation(x);      % 将state可能的下一个状态随机打乱成一个矩阵
        x0 = x0(1);                     % 取随机矩阵中的第一个值作为下一个状态x0
        taxi_num = grid_cnt(x0);        % taxi_num为x0网格的数据量
        % 如果车辆数目大于平均值
        % 如果大的超过一定比例，则折扣因子设为0.9,
        % 否则设为比例*0.6
        % 车辆数目不大于平均值
        % 如果小的超过一定比例，则折扣因子设为0.3
        % 否则设为比例*0.6
        if taxi_num > avg
            if taxi_num / avg * 0.6 > 0.9
                gamma = 0.9;
            else
                gamma = taxi_num / avg * 0.6;
            end
        else if taxi_num / avg * 0.6 < 0.3
                gamma = 0.3;
            else
                gamma = taxi_num / avg * 0.6;
            end
        end
    end
    % 寻找x0可能的下一个状态，用于计算QTable_max=max(QTable(x0,x0_next))
    x0_next = find(RTable(x0,:) >= 0);
    QTable_max = 0;
    for i = 1:size(x0_next, 2)
        q_val = QTable(x0, x0_next(i));
        QTable_max = max(QTable_max, q_val);
    end
    % 计算Q值表中QTable(state, x0)的值
    QTable(state, x0) = (1 - alpha) * QTable(state, x0) + alpha * (RTable(state, x0) + gamma * QTable_max);
end

% 规范化Q值表（即Q值表中最大值为100）
g = max(max(QTable));
if g > 0
    QTable = 100 * QTable / g; 
end
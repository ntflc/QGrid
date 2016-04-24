% 此函数用于统计车辆在不同网格间的转移次数
function [table] = TableStatistic(data, table)

% 找出不同的车辆id
taxi_id = unique(data(:, 1));
taxi_num = size(taxi_id, 1);

% 对每一辆车进行遍历，按照其走过的轨迹把相应网格中的数目加1
for i = 1:taxi_num
    taxi_tmp = data(data(:, 1) == taxi_id(i), :);
    % 按照时间顺序对其进行排序，以便统计轨迹状态
    taxi_tmp = sortrows(taxi_tmp, 5);
    % 取排序后的第6列，即网格编号
    taxi_grid = taxi_tmp(:, 6);
    % 对于同一辆车，留下其相邻时间内在同一网格的一条GPS信息，删除其在最近时间内在同一网格的GPS信息
    taxi_grid = DeleteNeighbors(taxi_grid);
    % 注意此处可能出现的状况，由于采样粒度的关系，采样点有可能在一个网格中，或者前后采样点的网格根本不相邻，因此需要判断。
    % 如果是前一种情况可能是粒度过细，就等待下一个GPS轨迹点再去定位网格，如果是后一种情况就舍弃
    taxi_grid_num = size(taxi_grid, 1);
    if (taxi_grid_num >= 3)
        for j = 1:(taxi_grid_num - 2)
            pre_grid = taxi_grid(j);
            curr_grid = taxi_grid(j + 1);
            next_grid = taxi_grid(j + 2);
            row1 = find(table(:, 1) == pre_grid);
            row2 = find(table(:, 2) == curr_grid);
            row3 = find(table(:, 3) == next_grid);
            row4 = intersect(row1, row2);
            row = intersect(row3, row4);
            if (size(row, 1) > 0)
                table(row, 4) = table(row, 4) + 1;
            end
        end
    end
end
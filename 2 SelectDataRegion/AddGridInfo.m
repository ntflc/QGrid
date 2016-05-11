% 用于给每一条记录添加上一个时刻的网格编号
function [output_args] = AddGridInfo(input_args, grid_length, x_min, y_min, row_num)

% 对输入数据进行排序，优先车辆ID，其次时间
input_args = sortrows(input_args, [1, 5]);
% 新建矩阵grid_id，与input_args行数相同，共2列，第一列为当前网格，第二列为上一个网格
grid_id = zeros(size(input_args, 1), 2);
% 定义上一个出租车id为0，以区分第一组数据
pre_taxi_id = 0;
for i = 1:size(input_args, 1)
    % 当前出租车id
    curr_taxi_id = input_args(i, 1);
    % 当前出租车所在网格
    x = ceil((input_args(i, 2) - x_min) / grid_length);
    y = ceil((input_args(i, 3) - y_min) / grid_length);
    grid = (x - 1) * row_num + y;
    % 将当前网格号存入grid_id第一列
    grid_id(i, 1) = grid;
    % 如果当前车辆是该车辆ID的第一条数据，则上一个网格还是本身，否则是上一个时间点的网格
    if (curr_taxi_id ~= pre_taxi_id)
        grid_id(i, 2) = grid;
    else
        grid_id(i, 2) = grid_id(i - 1, 1);
    end
    % 修改上一个出租车id值
    pre_taxi_id = curr_taxi_id;
end
% 输出矩阵为input_args加grid_id
[output_args] = [input_args grid_id];
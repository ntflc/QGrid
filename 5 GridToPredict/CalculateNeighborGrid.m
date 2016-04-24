% 此函数用于生成table表，表示网格之间的关系，用于预测网格间转移概率
function [table] = CalculateNeighborGrid(row_num, col_num)

table = [];
grid_num = row_num * col_num;

for i_grid = 1:grid_num
    neighbor_grid = [];
    % 计算i网格的行、列值
    i_row = ceil(i_grid / col_num);
    i_col = i_grid - (i_row - 1) * col_num;
    % 根据当前网格计算邻居网格
    % 从左上方网格开始按顺时针判断
    % 左上方网格
    row = i_row + 1;
    col = i_col - 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 正上方网格
    row = i_row + 1;
    col = i_col;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 右上方网格
    row = i_row + 1;
    col = i_col + 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 正右方网格
    row = i_row;
    col = i_col + 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 右下方网格
    row = i_row - 1;
    col = i_col + 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 正下方网格
    row = i_row - 1;
    col = i_col;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 左下方网格
    row = i_row - 1;
    col = i_col - 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    % 正左方网格
    row = i_row;
    col = i_col - 1;
    if row >= 1 && row <= row_num && col >= 1 && col <= col_num
        neighbor_grid = [neighbor_grid; (row - 1) * col_num + col];
    end
    neighbor_grid_num = size(neighbor_grid, 1);
    % 生成table
    for i = 1:neighbor_grid_num
        for j = 1:neighbor_grid_num
            table = [table; neighbor_grid(i) i_grid  neighbor_grid(j) 0];
        end
    end
end

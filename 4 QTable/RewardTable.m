% 此函数用于生成Reward表
function [RTable] = RewardTable(row_num, col_num)

% 计算网格总数，初始化Reward表
grid_num = row_num * col_num;
RTable = zeros(grid_num, grid_num, grid_num);

% 对每一种目标网格进行循环
for dest_grid = 1:grid_num
    % 将该目标网格的Reward表初始化值为-1
    RTable(:, :, dest_grid) = ones(grid_num, grid_num) * -1;
    % 每一种目标网格情况下，计算其Reward表
    for i_grid = 1:grid_num
        % 计算i网格的行、列值
        i_col = ceil(i_grid / row_num);
        i_row = i_grid - (i_col - 1) * row_num;
        for j_grid = 1:grid_num
            % 计算j网格的行、列值
            j_col = ceil(j_grid / row_num);
            j_row = j_grid - (j_col - 1) * row_num;
            % 判断i到j是否可达，如果可达且j为目标网格则Reward值为100，如果可达且j非目标网格则Reward值为0
            % 判断i和j是否为同一点
            if (i_grid == j_grid)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点左上方
            if (i_row == j_row - 1 && i_col == j_col - 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点正上方
            if (i_row == j_row - 1 && i_col == j_col)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点右上方
            if (i_row == j_row - 1 && i_col == j_col + 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点正右方
            if (i_row == j_row && i_col == j_col + 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点右下方
            if (i_row == j_row + 1 && i_col == j_col + 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点正下方
            if (i_row == j_row + 1 && i_col == j_col)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点左下方
            if (i_row == j_row + 1 && i_col == j_col - 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
            % 判断i点是否在j点正左方
            if (i_row == j_row && i_col == j_col - 1)
                if (j_grid == dest_grid)
                    RTable(i_grid, j_grid, dest_grid) = 100;
                else
                    RTable(i_grid, j_grid, dest_grid) = 0;
                end
            end
        end
    end
end

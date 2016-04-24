% 对于同一辆车，留下其相邻时间内在同一网格的一条GPS信息，删除其在最近时间内在同一网格的GPS信息
function [taxi_grid] = DeleteNeighbors(data)

i = 1;
while i < length(data)
    if data(i) == data(i + 1)
        data(i + 1) = [];
    else
        i = i + 1;
    end
end
taxi_grid = data;
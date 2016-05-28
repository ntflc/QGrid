% GPSR

% 导入数据
load('taxi20070201.mat');
load('taxi20070202.mat');
load('taxi20070203.mat');
load('taxi20070204.mat');
load('taxi20070205.mat');
load('taxi20070206.mat');
load('taxi20070207.mat');
load('taxi20070208.mat');
load('taxi20070209.mat');

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
load('taxi20070209.mat');

% QGrid
for radius = 200:100:500 %radius = 200:100:500
    for t_delta = 5:5:20 %t_delta = 5:5:20
        for TTL = 10:10:50 %TTL = 10:10:50
            gps_data = taxi20070209;
            % 选出指定时间段内的GPS数据
            t_start = 10 * 60 * 60;     % 起始时间为10点
            t_end = 11 * 60 * 60;       % 终止时间为11点
            gps_data = gps_data(gps_data(:, 5) >= t_start & gps_data(:, 5) < t_end, :);
            % 把时间分片化，间隔为t_delta
            gps_data(:, 5) = floor(gps_data(:, 5) / t_delta);
            % 如果gps_data为空，则跳过
            if size(gps_data, 1) <= 0
                continue;
            end
            
            % *****进行消息传递*****
            % 假设1s产生10条消息,则一个时间片内产生t_delta*10条消息
            message_delta_num = t_delta * 10;
            % 记录消息的条数
            message_cnt = 0;
            % 记录不同消息的条数，不包括复制后的数值
            message_id = 0;
            message = [];
            % 设置起始时间
            start_time = min(gps_data(:,5));
            end_time = max(gps_data(:,5));
            for time = start_time:end_time
                select_taxi = gps_data(gps_data(:, 5) == time, :);
                % 有可能一个时间片有一辆车的多条记录，因此要进行去重
                [B,I,J] = unique(select_taxi(:,1));
                select_taxi = select_taxi(I,:);
                if size(select_taxi, 1) <= 0
                    continue;
                end
                
                % ***产生消息***
                % 初始化一个时间片内产生的所有消息
                % 每个时间段产生一定条数的消息,end_time-TTL后不再产生新的消息
                if (time < end_time - TTL)
                    for i = 1:message_delta_num
                        message_cnt = message_cnt + 1;
                        message_id = message_id + 1;
                        % 随机选取源节点
                        source_id_row = randi(size(select_taxi,1)); % 随机选取该时间点GPS数据的一行
                        source_grid = select_taxi(source_id_row, 6);% 源节点车辆所在的网格编号
                        source_taxi = select_taxi(source_id_row, 1);% 源节点车辆的id
                        % 随机选取目标节点
                        dest_id_row = randi(size(gps_data,1));      % 随机选取整个时间段GPS数据的一行
                        dest_grid = gps_data(dest_id_row, 6);       % 目标节点网格
                        dest_x = gps_data(dest_id_row, 2);          % 目标节点x坐标
                        dest_y = gps_data(dest_id_row, 3);          % 目标节点y坐标
                        % 当前信息
                        curr_grid = source_grid;                    % 携带消息车辆所在的网格编号
                        curr_taxi = source_taxi;                    % 携带消息车辆的id
                        % 消息内容
                        message(message_cnt, 1) = message_id;       % 消息编号
                        message(message_cnt, 2) = source_grid;      % 源节点网格编号
                        message(message_cnt, 3) = source_taxi;      % 源节点车辆ID
                        message(message_cnt, 4) = curr_grid;        % 携带消息车辆所在的网格编号
                        message(message_cnt, 5) = curr_taxi;        % 携带消息车辆的id
                        message(message_cnt, 6) = dest_grid;        % 目标节点网格编号
                        message(message_cnt, 7) = dest_x;           % 目标节点x坐标
                        message(message_cnt, 8) = dest_y;           % 目标节点y坐标
                        message(message_cnt, 9) = time;             % 消息产生的时间
                        message(message_cnt, 10) = TTL;             % 消息的TTL
                        message(message_cnt, 11) = 0;               % 消息传递的跳数
                        message(message_cnt, 12) = 0;               % 消息是否传输成功，成功为1，等待传输为0
                    end
                end
                
                % ***传递消息***
                % 这一时刻的所有车辆的信息已经选出是select_taxi
                taxi_gps_message = select_taxi;
                for message_i = 1:message_cnt
                    % 如果消息等待传输，且TTL未到期
                    if message(message_i, 12) == 0 && message(message_i, 10) >= 1
                        % 首先更新当前消息的所在位置。此时寻找携带该消息的车辆，去判断这个消息所在的网格
                        taxi_id = message(message_i, 5);
                        curr_message_row = find(taxi_gps_message(:, 1) == taxi_id);
                        % 此时有该车辆的记录
                        if size(curr_message_row, 1) > 0
                            % 目前消息所在的网格
                            state = taxi_gps_message(curr_message_row, 6);
                            % 目标网格
                            dest = message(message_i, 6);
                            % 判断当前节点与目的节点的距离，不用判断当前网格与目的网格的关系
                            curr_x0 = taxi_gps_message(curr_message_row, 2);
                            curr_y0 = taxi_gps_message(curr_message_row, 3);
                            dest_x0 = message(message_i, 7);
                            dest_y0 = message(message_i, 8);
                            curr_dist = CalculateDistance(curr_x0, curr_y0, dest_x0, dest_y0);
                            % 如果目标节点在当前节点通信范围内，传递消息
                            if (curr_dist <= radius)
                                message(message_i, 11) = message(message_i, 11) + 1;
                                message(message_i, 12) = 1;
                                disp('**********成功一条**********');
                                continue;
                            % 否则考虑周围距离目标节点最近的车辆为下一跳车辆（可以为本身）
                            else
                                % 先筛选出当前节点周围方形区域内的节点（正方形边长=半径*2）
                                neighbor_candidate = taxi_gps_message((taxi_gps_message(:,2)>(taxi_gps_message(curr_message_row,2)-radius))&...
                                	(taxi_gps_message(:,2)<(taxi_gps_message(curr_message_row,2)+radius))&...
                                   	(taxi_gps_message(:,3)>(taxi_gps_message(curr_message_row,3)-radius))&...
                                   	(taxi_gps_message(:,3)<(taxi_gps_message(curr_message_row,3)+radius)),:);
                                % 从正方形区域内，筛选出传输范围内的节点
                                if size(neighbor_candidate, 1) > 0
                                    neighbor_num = 0;
                                    neighbor = [];
                                    for candidate_i = 1:size(neighbor_candidate, 1)
                                        candidate_x1 = neighbor_candidate(candidate_i, 2);
                                        candidate_y1 = neighbor_candidate(candidate_i, 3);
                                        candidate_x2 = taxi_gps_message(curr_message_row, 2);
                                        candidate_y2 = taxi_gps_message(curr_message_row, 3);
                                        candidate_dist = CalculateDistance(candidate_x1, candidate_y1, candidate_x2, candidate_y2);
                                        if candidate_dist <= radius
                                            neighbor_num = neighbor_num + 1;
                                            neighbor(neighbor_num, :) = neighbor_candidate(candidate_i, :);
                                        end
                                    end
                                    % 从传输范围内的节点，寻找距离目标节点最近的节点传递消息
                                    if neighbor_num > 0
                                        delta_x = neighbor(:, 2) - message(message_i, 7);
                                        delta_y = neighbor(:, 3) - message(message_i, 8);
                                        neighbor_dist = sqrt(delta_x.^2 + delta_y.^2);
                                        min_dist = min(neighbor_dist);
                                        % 如果该节点到目标节点距离比当前节点到目标节点距离更近，则传递该消息
                                        if min_dist < curr_dist
                                            % 选出距离最短的下一跳车辆信息，可能有多个
                                            next_taxi = neighbor(neighbor_dist == min_dist,:);
                                            % 如果有多个，随机选择一个；如果只有一个，随机的结果还是本身
                                            next_taxi_row = randi(size(next_taxi,1));
                                            next_taxi = next_taxi(next_taxi_row,:);
                                            % 更新message信息
                                            message(message_i, 4) = next_taxi(1, 6);
                                            message(message_i, 5) = next_taxi(1, 1);
                                            message(message_i, 11) = message(message_i, 11) + 1;
                                            disp('消息传递到周围的车辆');
                                            continue;
                                        end
                                    else
                                        continue;
                                    end
                                else
                                    continue;
                                end
                            end
                        else
                            continue;
                        end
                    else
                        continue;
                    end
                end
                % 如果一轮循环后，消息仍然没有传递成功，则TTL减1
                row = find (message(:, 12) == 0 & message(:, 10) > 0);
                if size(row, 1) > 0
                    message(row, 10) = message(row, 10) - 1;
                end
            end
            % *****结束消息传递*****
            
            % 消息统计
            delivery_ratio = sum(message(:, 12)) / message_cnt;
            success_message = message(message(:, 12) == 1, :);          % 传输成功的消息
            % 进行去重处理，将第一例相同message_id的消息去除
            [B I J] = unique(success_message(:, 1), 'rows');
            success_message = success_message(I, :);
            success_num = size(success_message, 1);                     % 传输成功消息的数量
            success_skip = sum(success_message(:, 11)) / success_num;   % 传输成功的消息的平均跳数
            success_delay = (success_num * TTL - sum(success_message(:, 10))) / success_num;    % 传输成功的消息的平均延迟
            number_of_forwarding = sum(message(:, 11)) / message_cnt;
            data = [data; grid_length, radius, t_delta, TTL, delivery_ratio, success_num, success_skip, success_delay, number_of_forwarding];
        end
    end
end

xlswrite('GPSR.xls', data, 'sheet1', 'A1');

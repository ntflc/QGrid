% ��GridCountStatistics�е����ݻ��Ƴ�ͼ��
% ��ͼ��֤���ù�ȥһ��ʱ��ѧϰ�õ���Qֵ������������Ϣ����

% ��ȡGridCountStatistics�е����ݣ�������������������������������GPS����
[row_num, col_num, grid_num, grid_list] = GridCountStatistics();

% �������ݣ���GPS��������ΪGPSռ��
taxi_cnt = sum(grid_list);
for i = 1:9
    grid_list(:, i) = grid_list(:, i) / taxi_cnt(1, i);
end

% ���л�ͼ������Ϊ�����ţ�����Ϊ��ͬ����ÿ�������GPS��ռ��
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
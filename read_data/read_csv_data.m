<<<<<<< HEAD
function read_csv_data(csv_file_path, output_mat_file_path, m, n)
=======
function read_csv_data(csv_file_path, output_mat_file_path, n, m)
>>>>>>> 60928989ca2afdc2dfa93ca3183dc1b1470fefb9
    % 读取CSV文件中的数据
    data = readmatrix(csv_file_path);
    
    % 提取时间步长数据
    data_time = data(:, 1);
    
    % 提取位移数据
    displacement_data = data(:, 2:end);

    data_x = 0:m-1; % x方向的数据点
    data_y = 0:n-1; % y方向的数据点
    
    % 获取时间点数
    t = length(data_time);
    
    % 初始化三维矩阵
<<<<<<< HEAD
    data_xyt = zeros(m, n, t);
=======
    data_xyt = zeros(n, m, t);
>>>>>>> 60928989ca2afdc2dfa93ca3183dc1b1470fefb9
    
    % 将数据重塑为三维矩阵，使用“贪吃蛇”顺序
    for time_index = 1:t
        displacement = displacement_data(time_index, :);
<<<<<<< HEAD
        reshaped_data = reshape(displacement, n, m)';% 列有限原则重塑为二维矩阵再转置
        for row = 1:n
            if mod(row, 2) == 0
                reshaped_data(:, row) = fliplr(reshaped_data(:, row));
=======
        reshaped_data = reshape(displacement, m, n)';
        for row = 1:n
            if mod(row, 2) == 0
                reshaped_data(row, :) = fliplr(reshaped_data(row, :));
>>>>>>> 60928989ca2afdc2dfa93ca3183dc1b1470fefb9
            end
        end
        data_xyt(:, :, time_index) = reshaped_data;
    end

    % 保存数据到MAT文件
    save(fullfile(output_mat_file_path, 'data.mat'), 'data_xyt', 'data_time', 'data_y', 'data_x');
    
    % 打印成功信息
    fprintf('Data successfully saved to %s\n', output_mat_file_path);
end
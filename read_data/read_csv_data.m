function read_csv_data(csv_file_path, output_mat_file_path, m, n)
    % 读取CSV文件中的数据
    data = readmatrix(csv_file_path);
    
    % 提取时间步长数据
    data_time = data(:, 1);
    
    % 提取位移数据
    displacement_data = data(:, 2:end);

    data_x=0:m-1; % x方向的数据点
    data_y=0:n-1;% y方向的数据点
    
    % 获取时间点数
    t = length(data_time);
    
    % 将数据重塑为三维矩阵，使用列优先顺序
    data_xyt = reshape(displacement_data', [n, m, t]);
    
    % 保存数据到MAT文件
    save(strcat(output_mat_file_path,'\data.mat'), 'data_xyt', 'data_time', 'data_y', 'data_x');
    
    % 打印成功信息
    fprintf('Data successfully saved to %s\n', output_mat_file_path);
end=
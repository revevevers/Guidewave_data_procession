function read_usd_to_mat_data(x_mat_file_path, y_mat_file_path, output_mat_file_path, n, m)
    
    % m, n是网格的长和宽
    % 加载.mat文件中的数据
    x_data_struct = load(x_mat_file_path); % 假设时间步长存储在 'x' 变量中
    y_data_struct = load(y_mat_file_path); % 假设数据存储在 'y' 变量中
    
    % 提取变量
    data_time = x_data_struct.x;
    data_xyt_origin = y_data_struct.y;
    
    % 获取时间点数
    t = size(data_xyt_origin, 2);
    
    % 将数据重塑为三维矩阵，使用列优先顺序
    data_xyt = reshape(data_xyt_origin', [n, m, t]);
    
    % 保存数据到.mat文件
    save(strcat(output_mat_file_path,'\data.mat'), 'data_xyt', 'data_time');
    
    % 打印成功信息
    fprintf('Data successfully saved to %s\n', output_mat_file_path);
end
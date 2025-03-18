function plot_WRMS(data_xyt, weights)
    % 绘制WRMS超声损伤成像的函数
    % data_time: 时间数据
    % data_xyt: 三维数据矩阵
    % weights: 权重数组

    % 参数设置
    num_x = size(data_xyt, 1);
    num_y = size(data_xyt, 2);
    num_time_samples = size(data_xyt, 3); % 时间样本数

    % 初始化WRMS矩阵
    WRMS_matrix = zeros(num_y, num_x); % WRMS矩阵

    % 对每个空间点进行处理
    for i = 1:num_y
        for j = 1:num_x
            % 提取局部信号
            signal = squeeze(data_xyt(j, i, :));
            
            % 计算WRMS值
            WRMS_value = sqrt(sum(weights .* (signal .^ 2)) / num_time_samples);
            
            % 存储WRMS值
            WRMS_matrix(i, j) = WRMS_value;
        end
    end

    % 生成坐标网格
    [X, Y] = meshgrid(1:num_x, 1:num_y);
    WRMS_matrix = rot90(WRMS_matrix,2);
    
    % 显示WRMS图像
    figure;
    surf(Y, X, WRMS_matrix); % 使用 surf 显示WRMS
    shading interp; % 插值平滑
    colorbar; % 显示颜色条
    view([0, 90]);
    xlabel('X (点数)');
    ylabel('Y (点数)');
    zlabel('WRMS');
    title('超声损伤成像（WRMS）');
    set(gca, 'XTick', 0:10:max(num_y));
    set(gca, 'YTick', 0:10:max(num_x));
    axis equal; % 保证横纵坐标的单位长度相同
end
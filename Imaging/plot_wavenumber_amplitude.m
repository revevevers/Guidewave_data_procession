function plot_wavenumber_amplitude(data_time, data_xyt, f)
    % 绘制波数域幅值图像的函数
    % f: 设定频率参数

    % 参数设置
    fs = 1 / (data_time(2) - data_time(1)); % 采样频率
    num_x = size(data_xyt, 2);
    num_y = size(data_xyt, 1);
    num_time_samples = size(data_xyt, 3); % 时间样本数

    % 设定开始点和结束点为全部时间范围
    start_point = 1;
    end_point = num_time_samples;
    window_size = end_point - start_point + 1; % 窗口大小（样本点数）

    % 创建空间窗口函数（汉宁窗）
    hanning_window = hann(window_size);

    % 初始化幅值矩阵
    amplitude_matrix = zeros(num_x, num_y); % 幅值矩阵

    % 对每个空间点进行处理
    for i = 1:num_x
        for j = 1:num_y
            % 提取短时间波场
            short_wave_field = squeeze(data_xyt(j, i, start_point:end_point)) .* hanning_window;

            % 进行傅里叶变换
            fft_result = fft(short_wave_field); % 进行傅里叶变换

            % 计算波数幅值
            wave_amplitude = abs(fft_result); % 计算幅值

            % 计算对应频率的波数
            freq_index = round(f / (fs / num_time_samples)); % 找到对应频率的索引
            if freq_index > length(wave_amplitude)
                continue; % 如果频率索引超出范围，跳过
            end

            % 计算局部波数幅值
            amplitude_matrix(i, j) = wave_amplitude(freq_index); % 直接取对应频率的幅值
        end
    end

    % 显示幅值图像
    data_x = 1:num_x;
    data_y = 1:num_y;
    
    figure;
    surf(data_x, data_y, amplitude_matrix); % 使用 surf 显示幅值
    shading interp; % 插值平滑
    colorbar; % 显示颜色条
    view([0,90]);
    xlabel('X (mm)');
    ylabel('Y (mm)');
    zlabel('幅值');
    title('波数域幅值分布');

    % 对图像进行平滑处理
    smooth_image = imgaussfilt(amplitude_matrix, 1); % 使用高斯滤波进行平滑处理，sigma=1

    % 显示平滑后的图像
    figure;
    surf(data_x, data_y, smooth_image); % 使用 surf 显示平滑后的幅值
    shading interp; % 插值平滑
    colorbar; % 显示颜色条
    view([0,90]);
    xlabel('X (mm)');
    ylabel('Y (mm)');
    zlabel('平滑后的幅值');
    title('平滑后的波数域幅值分布');
end
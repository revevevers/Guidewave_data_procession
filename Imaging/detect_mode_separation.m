function [mode_separation_map] = detect_mode_separation(data_xyt, fs, time_window)
    % 检测模态分离位置的函数，添加时间窗
    % 输入:
    % data_xyt: 三维数据矩阵 [41×41×采样点数]
    % fs: 采样频率
    % time_window: [t0, t1] 时间窗口(微秒)，例如[85, 120]
    
    % 获取数据维度
    [num_y, num_x, num_t] = size(data_xyt);
    
    % 初始化模态分离矩阵
    mode_separation_map = NaN(num_y, num_x);
    
    % 将时间窗口转换为采样点索引
    n0 = floor(time_window(1)*(1e-6)*fs);
    n1 = floor(time_window(2)*(1e-6)*fs);
    
    % 对每个扫描点进行处理
    for i = 1:num_y
        for j = 1:num_x
            % 1. 提取时间窗口内的信号
            signal = squeeze(data_xyt(i, j, n0:n1));
            
            % 2. 信号预处理
            % 去除直流分量
            signal = signal - mean(signal);
            
            % 3. 计算信号的短时傅里叶变换 (STFT)
            window_length = 256; % 窗口长度
            overlap = 128;       % 重叠长度
            [s, f, t] = stft(signal, fs, 'Window', hamming(window_length), 'OverlapLength', overlap, 'FFTLength', 512);
            
            % 4. 计算频谱能量
            spectral_energy = sum(abs(s).^2, 1);
            
            % 5. 检测模态分离
            % 通过分析频谱能量的变化来检测模态分离
            energy_threshold = 0.1 * mean(spectral_energy) + 2 * std(spectral_energy);
            mode_separation_idx = find(spectral_energy > energy_threshold, 1, 'first');
            
            % 6. 记录模态分离位置
            if ~isempty(mode_separation_idx)
                mode_separation_map(i, j) = t(mode_separation_idx) + n0/fs; % 加上时间窗起始时间
            end
        end
    end
    
    % 显示模态分离图像
    figure;
    surf(1:num_x, 1:num_y, mode_separation_map);
    view([0, 90]);
    shading interp;
    colormap(jet); % 使用jet颜色图增强对比度
    colorbar;
    xlabel('x方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    ylabel('y方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    title('模态分离位置检测', 'FontName', 'Times New Roman', 'FontSize', 16);
end
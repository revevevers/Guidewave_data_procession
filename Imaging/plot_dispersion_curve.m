function plot_dispersion_curve(data_xyt, fs, time_window, direction, index)
    % 绘制某一行或某一列的频谱图，类似于频散曲线
    % 输入:
    % data_xyt: 三维数据矩阵 [41×41×采样点数]
    % fs: 采样频率
    % time_window: [t0, t1] 时间窗口(微秒)，例如[85, 120]
    % direction: 'row' 或 'column'，指定绘图方向
    % index: 指定行或列的索引
    
    % 将时间窗口转换为采样点索引
    n0 = floor(time_window(1)*(1e-6)*fs);
    n1 = floor(time_window(2)*(1e-6)*fs);
    
    % 获取数据维度
    [num_y, num_x, ~] = size(data_xyt);
    
    % 确保n1和n0的值在有效范围内
    if n0 < 1 || n1 > size(data_xyt, 3)
        error('时间窗口超出信号范围，请检查时间窗口设置。');
    end
    
    % 计算频率分量的数量
    num_freq_bins = floor((n1 - n0) / 2) + 1; % 确保为正整数
    energy_spectrum = zeros(num_x, num_freq_bins); % 只存储频谱能量
    
    % 对指定行或列的每个点进行处理
    for k = 1:num_x
        if strcmp(direction, 'row')
            signal = squeeze(data_xyt(index, k, n0:n1));
        else
            signal = squeeze(data_xyt(k, index, n0:n1));
        end
        
        % 信号预处理
        signal = signal - mean(signal);
        
        % 计算信号的傅里叶变换，增加FFT长度
        Y = fft(signal, 2048); % 使用2048点FFT
        P2 = abs(Y/(n1-n0));
        P1 = P2(1:1025); % 取前半部分
        P1(2:end-1) = 2*P1(2:end-1);
        
        % 存储频谱
        energy_spectrum(k, :) = P1(1:num_freq_bins).^2; % 存储能量谱
    end
    
    % 计算频率轴
    f = fs*(0:((2048/2)))/(2048);
    
    % 绘制频散曲线
    figure;
    imagesc(1:num_x, f(1:num_freq_bins), energy_spectrum');
    axis xy;
    colormap(jet);
    colorbar;
    if strcmp(direction, 'row')
        xlabel('Column Index');
        title(['Dispersion Curve for Row ', num2str(index)]);
    else
        xlabel('Row Index');
        title(['Dispersion Curve for Column ', num2str(index)]);
    end
    ylabel('Frequency (Hz)');
end
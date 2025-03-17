function spectral_imaging(data_xyt, fs)
    [num_y, num_x, ~] = size(data_xyt);
    
    % 设置时间窗口
    t0 = 85;  % 微秒
    t1 = 120; % 微秒
    n0 = floor(t0*(1e-6)*fs);
    n1 = floor(t1*(1e-6)*fs);
    
    % 初始化频谱能量矩阵
    spectral_map = zeros(num_y, num_x);
    
    % 设置感兴趣的频率范围（根据实际信号调整）
    f_low = 150e3;  % 150kHz
    f_high = 250e3; % 250kHz
    
    for i = 1:num_y
        for j = 1:num_x
            % 提取信号
            signal = squeeze(data_xyt(i, j, n0:n1));
            
            % 计算频谱
            L = length(signal);
            Y = fft(signal);
            P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            f = fs*(0:(L/2))/L;
            
            % 计算指定频率范围内的能量
            idx = find(f >= f_low & f <= f_high);
            spectral_map(i, j) = sum(P1(idx));
        end
    end
    
    % 绘制频谱能量图
    figure;
    surf(1:num_x, 1:num_y, spectral_map);
    view([0, 90]);
    shading interp;
    colorbar;
    xlabel('x方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    ylabel('y方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    title('频谱能量成像', 'FontName', 'Times New Roman', 'FontSize', 16);
end
function c_scan_amplitude(data_xyt, fs)
    [num_y, num_x, ~] = size(data_xyt);
    
    % 设置时间窗口（根据实际信号调整）
    t0 = 85;  % 起始时间（微秒）
    t1 = 120; % 结束时间（微秒）
    n0 = floor(t0*(1e-6)*fs);
    n1 = floor(t1*(1e-6)*fs);
    
    % 初始化幅值矩阵
    amplitude_map = zeros(num_y, num_x);
    
    % 计算每个点的峰值幅值
    for i = 1:num_y
        for j = 1:num_x
            signal = squeeze(data_xyt(i, j, n0:n1));
            amplitude_map(i, j) = max(abs(signal));
        end
    end
    
    % 绘制C扫描图
    figure;
    surf(1:num_x, 1:num_y, amplitude_map);
    view([0, 90]);
    shading interp;
    colorbar;
    xlabel('x方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    ylabel('y方向 (点数)', 'FontName', 'Times New Roman', 'FontSize', 16);
    title('C扫描幅值图', 'FontName', 'Times New Roman', 'FontSize', 16);
end
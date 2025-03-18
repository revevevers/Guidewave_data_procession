function c_scan_amplitude(data_xyt)
    [num_y, num_x, num_t] = size(data_xyt);
    
    % 初始化幅值矩阵
    amplitude_map = zeros(num_y, num_x);
    
    % 计算每个点的峰值幅值
    for i = 1:num_y
        for j = 1:num_x
            signal = squeeze(data_xyt(i, j, :));
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
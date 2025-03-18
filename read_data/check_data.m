function check_data(data_xyt, data_time, time)

    % 查看某一点的时域信号
    figure(1);
    signal_y = floor(size(data_xyt, 2)/2);
    signal_x = floor(size(data_xyt, 1)/2);
    plot(data_time, permute(data_xyt(signal_x,signal_y,:), [3,1,2]));
    xlabel('Time (s)');
    ylabel('Magnitude');
    title(['Signal of (',num2str(signal_x),',',num2str(signal_y),')']);
    title(['Envelope of Signal at Point (', num2str(i), ', ', num2str(j), ')']);

    % 查看某时刻波场图
    % 假设每个点间的实际距离为 dx 和 dy
    dx = 1; % x方向上每个点之间的距离（单位：mm）
    dy = 1; % y方向上每个点之间的距离（单位：mm）

    % 根据实际距离调整 x 和 y 坐标
    num_x = (0:size(data_xyt, 1)-1) * dx;
    num_y = (0:size(data_xyt, 2)-1) * dy;

    % 采样频率
    fs = 1 / (data_time(2) - data_time(1));
    n0 = floor(time * (1e-6) * fs);

    % 提取单时刻数据
    wave_field = data_xyt(:,:,n0);

    % 绘制单时刻图像
    figure;
    surf(num_y, num_x, wave_field);
    view([0, 90]);
    shading interp;
    colorbar;
    xlabel('x / mm', 'FontName', 'Times New Roman', 'FontSize', 16);
    ylabel('y / mm', 'FontName', 'Times New Roman', 'FontSize', 16);
    title('查看单时刻');
    set(gca, 'XTick', 0:10:max(num_y));
    set(gca, 'YTick', 0:10:max(num_x));
    axis equal; % 保证横纵坐标的单位长度相同
    grid on;

end
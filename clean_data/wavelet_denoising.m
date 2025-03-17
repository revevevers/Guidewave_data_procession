function denoised_signal = wavelet_denoising(signal)
    % 使用db4小波进行5层分解
    [C, L] = wavedec(signal, 5, 'db4');
    
    % 计算每一层的小波系数的标准差，用于阈值设置
    threshold = 0.3 * median(abs(C)) / 0.6745;  % 使用一个自适应阈值
    % 对小波系数进行硬阈值处理
    C = wthresh(C, 's', threshold);  % 对小波系数进行软阈值处理
    
    % 使用阈值后的系数重构信号
    denoised_signal = waverec(C, L, 'db4');
end
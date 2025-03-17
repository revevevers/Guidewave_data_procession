function xcorr_imaging(clean_data, fs)

    num_x = size(clean_data,2);
    num_y = size(clean_data,1);
    data_x = 1:1:num_x;
    data_y = 1:1:num_y;
    clean_data = clean_data.*50000000000;
    TOF = zeros(num_y,num_x);
    t0 = 85;t1 = 110; %多少μ秒 100
    n0 = floor(t0.*(1e-6).*fs);
    n1 = floor(t1.*(1e-6).*fs);
    for i = 1:num_y
        for j = 1:num_x-1
            data1 = permute(clean_data(i,j+1,:),[3,1,2]);
            data2 = permute(clean_data(i,j,:),[3,1,2]);
            [a1,b1]=xcorr(data1,data2 ,'coeff');%原始缺陷数据
            % figure; %画互相关图像
            % plot(b1,a1,'LineWidth',2);
            [m,p] = max(a1);
            TOF(i,j) = b1(p);%表示从位置 (i, j) 处的信号与其相邻位置 (i, j+1) 处的信号之间的时延。
            if i == 25&&j == 14
                disp(max(a1));
                disp(b1(p));
            end
        end
    end
    figure;surf(data_x,data_y,TOF);
    shading interp;colorbar;view([0,90]);
    xlabel('x / mm','FontName','Times New Roman','FontSize',20);
    ylabel('y /mm','FontName','Times New Roman','FontSize',20);
end
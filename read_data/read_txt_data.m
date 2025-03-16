clc
clear all
%% 读取数据

% 实验时记录扫描网格
m = 41;
n = 41;
fs = 6.25e6;%采样频率
l = 2500;%时间点数
ad = 'E:/Downlode/sch/项目/热防护材料脱粘损伤成像/超声数据/25.1.08_压电激励导波CC气凝胶/新建文件夹';
name = 'Scan_time';%文件名前面相同的部分

numdata=m*n;
data_xyt_origin=zeros(m,n,l); %定义三维矩阵
data_xytnarrow=zeros(m,n,l); 
data_xyt_double=zeros(m,n,l); 
for a=1:1:numdata % 读取
       len=length(num2str(a));%根据第a个文件的文件名来读取文件
             if len == 1
                 file_name_single = strcat(name,'____', num2str(a),'.txt');
             elseif len == 2
                 file_name_single = strcat(name,'___', num2str(a),'.txt');
             elseif len == 3
                 file_name_single = strcat(name,'__', num2str(a),'.txt');
             elseif len == 4
                 file_name_single = strcat(name,'_', num2str(a),'.txt');

             end
    
        A = importdata(strcat(ad,'/',file_name_single));
                 
        %求第a个点的行、列坐标
        if mod(a,m)==0
            ah=m; 
            al=floor(a/m);
        else
            ah=mod(a,m);
            al=floor(a/n)+1;
        end
        data_xyt_origin(ah,al,:)=A.data(:,2);%原始信号
end

data_time=A.data(:,1);% 从时间数据
data_x=0:m; % x方向的数据点
data_y=0:n;% y方向的数据点

% 带通滤波
for j = 1:m
     for i = 1:n   
     data_xytnarrow(i,j,:) = wordfilter(180,220,6.25,data_xyt_origin(i,j,:)); 
     %越滤波幅值越小时间延迟也越长这是为什么？
     end
end
data_xyt(:,:,:) = data_xytnarrow(:,:,:);

% 查看某一点的时域信号
% figure(1);
% signal_x = 18;
% signal_y = 18;
% data_xyt(:,:,:) = data_xytnarrow(:,:,1:l);%滤波后信号
% narrow = permute(data_xyt(5,:,:), [2,3,1]);%变换一下矩阵
% plot(data_time, permute(data_xyt(signal_x,signal_y,:), [3,1,2]));
% xlabel('Time (s)');
% ylabel('Magnitude');
% title(['Signal of (',num2str(signal_x),',',num2str(signal_y),')']);
% title(['Envelope of Signal at Point (', num2str(i), ', ', num2str(j), ')']);

% 查看某时刻波场图
% t0 = 100; %多少μ秒 95
% n0 = floor(t0.*(1e-6).*fs);
% figure(2);
% surf(data_x,data_y,data(:,:,n0));
% view([0,90]);
% shading interp;
% colorbar;view([0,90]);
% xlabel('x / mm','FontName','Times New Roman','FontSize',16);
% ylabel('y / mm','FontName','Times New Roman','FontSize',16);title('查看单时刻');
% set(gca,'XTick',[0:10:100]);
% set(gca,'YTick',[-50:10:50]);
% grid on;

%  保存数据
save([strcat(ad,'\2024.11.21data.mat')],'data_xyt','data_time','data_x','data_y');
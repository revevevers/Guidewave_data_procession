function [temp_data_filtered2] = wordfilter(low_fre_kHz,high_fre_kHz,sample_fre_MHz,beilvbo)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
temp_filter=[low_fre_kHz high_fre_kHz];% 带通滤波下截止频率和上截止频率，单位kHz
fs = sample_fre_MHz;
temp_data_fs=fs;%采样率，单位MHz
temp_wn=[temp_filter(1)*2/temp_data_fs*1e-3,temp_filter(2)*2/temp_data_fs*1e-3];%fs单位MHz temp_filter单位kHz
if temp_wn(2)>=1
    [b,a]=butter(4,temp_wn(1),'high');
else
    [b,a]=butter(4,temp_wn);
end
temp_data_filtered2=filter(b,a,beilvbo);%temp_data是被滤波信号，temp_data_filtered2是滤波后信号
end


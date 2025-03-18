clear all


read_csv_data('E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\100_kHz_23_123_2829_Points\data_2.csv', 'G:\ANW\Guidewave_data_procession', 23, 123);

load("data.mat");

%% 
f = 100e3;
fs = 1e-6 / (data_time(2) - data_time(1)); % 单位MHz
time = 40;
data_xyt = wordfilter(80,120,fs,data_xyt);

check_data(data_xyt, data_time, time);
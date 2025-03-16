filename='E:\Downlode\sch\项目\热防护材料脱粘损伤成像\超声数据\25.1.08_压电激励导波CC气凝胶\Scan_time.svd';
domainname='Time';
channelname= 'Vib';
signalname='Velocity';
displayname='Samples';
point=0;
frame=0;
[x,y,usd] = GetPointData(filename, domainname, channelname, signalname, displayname, point, frame);
plot(y(2,:));
read_usd_to_mat_data(x_mat_file_path, y_mat_file_path, output_mat_file_path, n, m)


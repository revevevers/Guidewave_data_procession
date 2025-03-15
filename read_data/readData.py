# from scipy.io import loadmat
import h5py
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from scipy.io import savemat, loadmat
import csv
import re

# from scipy.interpolate import griddata, ndgriddata
# from matplotlib.animation import FFMpegWriter


def read_h5_data(name):
    with h5py.File(name) as dataFile:
        print(dataFile.keys())
        a_group_key = list(dataFile.keys())[0]
        # Get the data
        data = list(dataFile[a_group_key])
    return data

# 读取 data.h5 文件后，得到的 data 是一个二维数组，其中每一列代表一个时间点的数据。
# data 的形状为 (n, m)，其中 n 是空间点的数量，m 是时间点的数量。

def read_csv_data(filepath):
    with open(filepath, 'r') as file:
        data = []
        for line in file:
            # 使用 re.split 方法手动拆分每一行的数据
            row = [float(item) for item in re.split(r'\s+', line.strip()) if item]
            if row:
                data.append(row)
    data = np.array(data)
    time = data[:, 0]
    displacement = data[:, 1:]
    return time, displacement

def plot_h5_wavefield(figpath, data, coord, time):
    # Determine mesh
    delta_x = 1e-3
    delta_y = delta_x

    x_grid = np.arange(min(coord[:, 0]), max(coord[:, 0]), delta_x)
    y_grid = np.arange(min(coord[:, 1]), max(coord[:, 1]), delta_y)

    [XNew, YNew] = np.meshgrid(x_grid, y_grid)

    img = []  # some array of images
    frames = []  # for storing the generated images
    fig = plt.figure()
    zmax = 2e-2
    zmin = -2e-2

    # fig.colorbar(surf, shrink=0.5, aspect=5)
    for idx in range(0, int(len(time) / 4), 10):
        t = time[idx]
        X = coord[:, 0]
        Y= coord[:, 1]
        Z = data[:, idx]
        ZNew = griddata((X.ravel(), Y.ravel()), Z.ravel(), (np.transpose(XNew), np.transpose(YNew)), method='linear')
        plt.imshow(ZNew.T, extent=(0, 1, 0, 1), origin='lower', cmap='coolwarm', vmin=zmin, vmax=zmax)
        fig.suptitle('Time: ' + str(float(t)) + ' s', fontsize=16)
        filename = figpath + 'frame' + str(idx) + '.png'
        plt.savefig(filename, dpi=200)

def plot_csv_wavefield(figpath, time, displacement, grid_shape):
    nrows, ncols = grid_shape
    fig = plt.figure()
    zmax = np.max(displacement)
    zmin = np.min(displacement)

    for idx in range(0, len(time), 100):
        t = time[idx]
        Z = displacement[idx, :].reshape(nrows, ncols)
        plt.imshow(Z, extent=(0, 488e-3, 0, 88e-3), origin='lower', cmap='coolwarm', vmin=zmin, vmax=zmax)
        fig.suptitle('Time: ' + str(float(t)) + ' s', fontsize=16)
        filename = figpath + 'wavefield_frame' + str(idx) + '.png'
        plt.savefig(filename, dpi=200)

# region 读取 h5 文件
# path_data = 'E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\OGW_CFRP_Stringer_Wavefield_Intact\OGW_CFRP_Stringer_Wavefield_Intact\BURST_300kHz_5HC_3Vpp_x10\data_z.h5'
# path_coord = 'E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\OGW_CFRP_Stringer_Wavefield_Intact\OGW_CFRP_Stringer_Wavefield_Intact\BURST_300kHz_5HC_3Vpp_x10\coordinates.h5'
# path_time = r"E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\OGW_CFRP_Stringer_Wavefield_Intact\OGW_CFRP_Stringer_Wavefield_Intact\BURST_300kHz_5HC_3Vpp_x10\time.h5"

# data = read_h5_data(path_data)
# coord = read_h5_data(path_coord)
# time = read_h5_data(path_time)

# data = np.asarray(data)
# data = np.transpose(data)
# coord = np.asarray(coord)
# coord = np.transpose(coord)
# time = np.asarray(time)
# figpath = 'E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\PY\frames\\'
# plot_h5_wavefield(figpath, data, coord, time)

# region 读取 csv 文件
# csv_filepath = 'E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\\100_kHz_23_123_2829_Points\data_1.csv'
# figpath = 'E:\Downlode\sch\项目\热防护材料脱粘损伤成像\成像算法\开放数据集\\100_kHz_23_123_2829_Points\\wavefield_frames\\'
# time, displacement = read_csv_data(csv_filepath)
# plot_csv_wavefield(figpath, time, displacement, (23, 123))

# print(len(time))

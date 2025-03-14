import numpy as np
from scipy.io import savemat

# 创建一些示例数据
data = {
    'array1': np.array([1, 2, 3, 4, 5]),
    'array2': np.array([[1, 2, 3], [4, 5, 6]]),
    'scalar': 42,
    'string': 'Hello, MATLAB!'
}

# 将数据保存为 .mat 文件
savemat('example.mat', data)

print("数据已保存为 example.mat")
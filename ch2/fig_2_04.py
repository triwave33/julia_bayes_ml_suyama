from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import math

M = 5
pi = [0.4, 0.3, 0.3]
K = len(pi)
Multi = np.zeros((M+1, M+1))

def multinomial_distribution(M, pi, mk):
    val = math.factorial(M)
    for i in range(0, len(mk)):
        val *= pi[i] ** mk[i] / math.factorial(mk[i])
    return val

for m1 in range(M+1):
    for m2 in range(M - m1 + 1):
        m3 = M - (m1+m2)
        if m3 >= 0:
            val = multinomial_distribution(M, pi, [m1,m2,m3])
            Multi[m1, m2] = val



fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
_x = grid = range(0,M+1)
_y = grid = range(0,M+1)
_xx, _yy = np.meshgrid(_x,_y)
x,y = _xx.ravel(), _yy.ravel()
z = np.zeros_like(x) 

ax.bar3d(x,y,z, 1.,1.,Multi.T.ravel(), shade=True)
ax.set_xlim(0,10)
ax.set_ylim(0,10)
ax.set_zlim(0,0.2)
ax.set_xlabel('m1')
ax.set_ylabel('m2')
plt.show()


from mpl_toolkits import mplot3d
import numpy as np
import matplotlib.pyplot as plt

cm = plt.cm.RdBu



def get_Z(X, Y):
    Z = 0.8*np.sinc(np.sqrt(np.square(X) + np.square(Y))) + .8*np.sin(1.5*X + np.pi/4) +\
        0.5*np.sinc(np.sqrt((X-2) ** 2 + (Y-1) ** 2)) + \
        0.6*np.sinc(np.sqrt((X+1.5) ** 2 + (Y-1.5) ** 2)) +\
        0.3*X + 5.0 + 0.2*Y +\
        2*np.asarray(X > 0, dtype=float)* np.sin(0.5*X) +\
        (np.sqrt(X**2+Y**2)-np.sqrt(50)) * (np.sqrt(X**2 + Y**2) > np.sqrt(50))
    return Z

init = (np.asarray(3.8), np.asarray(2.5))

def get_path(init, SGD=False):
    iters = 10
    lr = 4
    c = init    
    l = [c]
    decay = 0.98
    for step in range(iters):
        alpha = lr*decay**step
        y, x = c
        z = get_Z(*np.meshgrid(np.linspace(x-1, x+1, 11), np.linspace(y-1, y+1, 11)))
        g_y, g_x = np.gradient(z)
        g_y, g_x = g_y[5,5], g_x[5,5]
        if SGD:
            g_y += np.random.randn()*0.05
            g_x += np.random.randn()*0.05
        c = y-alpha*g_y, x-alpha*g_x
        l.append(c)
    l_y, l_x = tuple(zip(*l))
    return np.asarray(l_y), np.asarray(l_x)

fig = plt.figure()
ax = plt.axes(projection='3d')


# BGD
bgd_y_path, bgd_x_path = get_path(init)

ax.plot(xs=bgd_x_path, ys=bgd_y_path, zs=get_Z(bgd_x_path, bgd_y_path), c='#234a28', lw=1, zorder=100, label='BGD')
# SGD
sgd_y_path, sgd_x_path = get_path(init, SGD=True)
ax.plot(xs=sgd_x_path, ys=sgd_y_path, zs=get_Z(sgd_x_path, sgd_y_path), c='#aaff00', lw=1, zorder=100, label='SGD')

lim = 5.0
x = np.linspace(-0.1 + min(bgd_x_path.min(), sgd_x_path.min()),
                .1+max(bgd_x_path.max(), sgd_x_path.max()), 256)
y = np.linspace(-.1 + min(bgd_y_path.min(), sgd_y_path.min()),
                .1+max(bgd_y_path.max(), sgd_y_path.max()), 256)
XX, YY = np.meshgrid(x, y)
Z = get_Z(XX, YY)
ax.plot_surface(XX, YY, Z, cmap=cm)

ax.set_zticks([])
plt.xticks([])
plt.yticks([])
plt.legend()
plt.show()


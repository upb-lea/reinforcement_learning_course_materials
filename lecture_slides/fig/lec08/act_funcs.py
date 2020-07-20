import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(-3, 3, 100)

tanh = np.tanh(x)
def sigmoid(_x):
    return 1 / (1+np.exp(-_x))
sig = sigmoid(x)
relu = np.clip(x, 0, None)

plt.plot(x, tanh, label='tanh', lw=4)
plt.plot(x, sig, label='sigmoid', lw=4)
plt.plot(x, relu, label='ReLU', lw=4)
plt.axhline(-1, ls='--', c='black')
plt.axhline(0, ls='--', c='black')
plt.axhline(1, ls='--', c='black')
plt.axvline(0, ls='--', c='black')
plt.ylim([-1, 1])
plt.xticks(list(range(-3, 4)))
plt.yticks([-1, -.5, 0, .5, 1])
plt.legend()
plt.show()

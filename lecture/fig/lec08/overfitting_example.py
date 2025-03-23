from sklearn.datasets import make_moons
from sklearn.preprocessing import StandardScaler
from matplotlib.colors import ListedColormap
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression as OLS
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from sklearn.neighbors import KNeighborsClassifier, KNeighborsRegressor
from sklearn.linear_model import Ridge
from sklearn.pipeline import make_pipeline


fig, axes = plt.subplots(1, 2, figsize=(6, 3))

## Classification
# generate data
X, y = make_moons(noise=0.4, random_state=0)

X = StandardScaler().fit_transform(X)
#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.4)

# train classifiers
clf1 = KNeighborsClassifier(n_neighbors=9)
clf2 = KNeighborsClassifier(n_neighbors=1)
clf1.fit(X, y)
clf2.fit(X, y)

# predict classifiers


x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5
h = 0.02
xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

Z1 = clf1.predict(np.column_stack((xx.ravel(), yy.ravel())))
Z1 = Z1.reshape(xx.shape)
Z2 = clf2.predict(np.column_stack((xx.ravel(), yy.ravel())))
Z2 = Z2.reshape(xx.shape)


# plot
cm = plt.cm.RdBu
cm_bright_redblue = ListedColormap(['#FF0000', '#0000FF'])
dark_green_hex = '#234a28'
bright_green_hex = '#aaff00'
cm_dark_green = ListedColormap([dark_green_hex])
cm_bright_green = ListedColormap([bright_green_hex])

ax = axes[0]
# Plot the training points
ax.scatter(X[:, 0], X[:, 1], c=y, cmap=cm_bright_redblue, s=10)
# Decision boundaries
ax.contour(xx, yy, Z1, alpha=0.8, cmap=cm_dark_green, levels=0)
ax.contour(xx, yy, Z2, alpha=0.8, cmap=cm_bright_green, levels=0)
ax.set_xlim(xx.min()/2, xx.max()/2)
ax.set_ylim(yy.min()/2, yy.max()/2)
ax.set_xticks(())
ax.set_yticks(())


## Regression

n = 20
# generate data
time = np.linspace(0, 1, n).reshape(-1, 1) + 3
signal = time + 0.2*np.random.randn(n).reshape(-1, 1)
weak_signal = time + 0.3*np.random.randn(n).reshape(-1, 1)
X = np.hstack([time, weak_signal])

ax = axes[1]
ax.scatter(time, signal, s=10, c='#0000FF')
ax.plot(time, OLS().fit(time, signal).predict(time), c=dark_green_hex)
ax.plot(time, KNeighborsRegressor(n_neighbors=2).fit(time, signal).predict(time), c=bright_green_hex)
ax.set_xticks(())
ax.set_yticks(())
plt.tight_layout()
plt.show()















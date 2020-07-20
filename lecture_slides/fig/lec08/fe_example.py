from sklearn.datasets import make_blobs
from sklearn.linear_model import LinearRegression as OLS
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

n_inliers = 300
blobs_params = {'n_samples':n_inliers, 'n_features':2}

X, y = make_blobs(centers=[[0, 0], [0, 0]], cluster_std=3,
               **blobs_params)

df = pd.DataFrame(X, columns=['X1', 'X2'])

df = df.assign(r=lambda x: np.sqrt(x.X1**2 + x.X2**2), theta=lambda x: np.arctan(x.X2/x.X1))

fig, axes = plt.subplots(1, 2, figsize=(6, 3))

inner_circle = df[df.r < 2]
outer_circle = df[df.r >= 2]

# Classifier FE
axes[0].scatter(inner_circle.X1, inner_circle.X2, s=3, c='red', label='class 1')
axes[0].scatter(outer_circle.X1, outer_circle.X2, s=3, c='blue', label='class 2')
axes[1].scatter(inner_circle.r, inner_circle.theta, s=3, c='red')
axes[1].scatter(outer_circle.r, outer_circle.theta, s=3, c='blue')
axes[0].legend(markerscale=3, ncol=2)
for i, ax in enumerate(axes):
    ax.set_yticks([])
    ax.set_xticks([])
    ax.set_ylabel('height' if i==0 else r'$\theta$')
    ax.set_xlabel('width' if i==0 else r'$r$')
plt.tight_layout()

# Regressor FE
fig, axes = plt.subplots(1, 2, figsize=(6,3))

time = np.linspace(0, 3, 200).reshape(-1, 1)
skewed_data = np.exp(time.ravel() + 0.5*np.random.randn(200)).reshape(-1, 1)

axes[0].scatter(time, skewed_data, s=3, c='green')
axes[0].scatter(time, OLS().fit(time, skewed_data).predict(time), s=3, c='orange', ls=':')
axes[1].scatter(time, np.log1p(skewed_data), s=3, c='magenta')
axes[1].scatter(time, OLS().fit(time, np.log1p(skewed_data)).predict(time), s=3, c='orange', ls=':')
for i, ax in enumerate(axes):
    ax.set_yticks([])
    ax.set_xticks([])
    ax.set_ylabel('signal' if i==0 else 'log signal')
    ax.set_xlabel('regressor')
plt.tight_layout()
plt.show()


import matplotlib.pyplot as plt
import numpy as np
import torch


def plot_surface(model, input_dim, visited_states, featurize):
    resolution = 100
    pos_vec = np.linspace(-1.2, 0.6, resolution)
    vel_vec = np.linspace(-0.07, 0.07, resolution)

    pos_mat, vel_mat = np.meshgrid(pos_vec, vel_vec)
    state_tensor = np.zeros([resolution, resolution, input_dim])

    # Preparing the state tensor
    for pos_idx, pos in enumerate(pos_vec):
        for vel_idx, vel in enumerate(vel_vec):
            state_tensor[vel_idx, pos_idx] = featurize(np.array([pos, vel]))

    state_tensor = torch.tensor(state_tensor.reshape(-1, input_dim), dtype=torch.float32)
    with torch.no_grad():
        q_mat = model(state_tensor)
        q_maxes = q_mat.max(1)[0].view(resolution, resolution).numpy()

    visited_states = np.array(visited_states)
    normalized_visited = np.zeros([len(visited_states[:, 0]), input_dim])
    for idx, (pos, vel) in enumerate(zip(visited_states[:, 0], visited_states[:, 1])):
        normalized_visited[idx] = featurize(np.array([pos, vel]))

    normalized_visited = torch.tensor(normalized_visited, dtype=torch.float32)
    with torch.no_grad():
        visited_values = model(normalized_visited)
        visited_values = visited_values.max(1)[0].numpy()

    # Plot
    fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
    ax.plot_surface(pos_mat, vel_mat, -q_maxes, cmap="viridis")
    ax.scatter(visited_states[:, 0], visited_states[:, 1], -visited_values - 0.05, color="red")
    ax.set_xlabel('\n\nposition')
    ax.set_ylabel('\n\nvelocity')
    ax.set_zlabel(r'$-V_\mathrm{greedy}$', labelpad=12)
    ax.view_init(50, -135)
    plt.show()
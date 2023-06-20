# Exercise 12
In our last exercise we will examine the methods of policy gradient which allow us to set up control algorithms on environments with continuous state AND action space.
The environment under consideration is given by the LunarLander from OpenAI's `gym`. This toy example is based upon the arcade game [Lunar Lander by Atari](https://en.wikipedia.org/wiki/Lunar_Lander_(video_game_genre))
and is defined by an 8-dimensional (continuous) state space and a 2-dimensional (continuous) action space. Plenty of challenges!
## Tasks:
  1. Monte-Carlo policy gradient (REINFORCE) using a Gaussian policy
  2. Actor-Critic algorithm with TD(0) targets using a Gaussian policy

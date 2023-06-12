Reinforcement Learning Course Materials
=======================================
[![Build Status](https://github.com/upb-lea/reinforcement_learning_course_materials/actions/workflows/blank.yml/badge.svg)](https://github.com/upb-lea/reinforcement_learning_course_materials/actions/workflows/blank.yml)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/LICENSE)
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![made-with-latex](https://img.shields.io/badge/Made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/)

Lecture notes, tutorial tasks including solutions as well as online videos for the reinforcement learning course hosted by Paderborn University. Source code for the entire course material is open and everyone is cordially invited to use it for self-learning (students) or to set up your own course (lecturers).
![Example](./img/wordcloud.svg)

**Note: This course repository is being gradually revised and streamlined. Until summer 2023, there may therefore be inconsistencies between the individual sections.
The previous versions are all archived as separate releases and thus still available.**

# Lecture Content

01. Introduction to Reinforcement Learning
    * [Lecture video, part 1](https://www.youtube.com/watch?v=YqlNOCD0rfA)
    * [Lecture video, part 2](https://youtu.be/Yd99sn-64Z8)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture01.pdf)   
02. Markov Decision Processes
    * [Lecture video](https://www.youtube.com/watch?v=ywn81iGQISE)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture02.pdf) 
03. Dynamic Programming
    * [Lecture video](https://www.youtube.com/watch?v=vjIiYdidFPY)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture03.pdf) 
04. Monte Carlo Methods
    * [Lecture video](https://www.youtube.com/watch?v=GBL0ArlONrM)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture04.pdf) 
05. Temporal-Difference Learning
    * [Lecture video](https://www.youtube.com/watch?v=Rnf9Wanxnj8)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture05.pdf) 
06. Multi-Step Bootstrapping
    * [Lecture video](https://www.youtube.com/watch?v=YYTSZTyjbQ4)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture06.pdf) 
07. Planning and Learning with Tabular Methods
    * [Lecture video](https://www.youtube.com/watch?v=gvJ3__GmHqo)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture07.pdf) 
08. Function Approximation with Supervised Learning
    * [Lecture video](https://www.youtube.com/watch?v=tXAxTiuvges)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture08.pdf) 
09. On-Policy Prediction with Function Approximation
    * [Lecture video](https://www.youtube.com/watch?v=aA3MFRHrrtg)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture09.pdf) 
10. Value-Based Control with Function Approximation
    * [Lecture video](https://www.youtube.com/watch?v=YNf-ezTKB78)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture10.pdf) 
11. Eligibility Traces
    * [Lecture video](https://www.youtube.com/watch?v=xLUXeASnqwE)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture11.pdf) 
12. Policy Gradient Methods
    * [Lecture video](https://www.youtube.com/watch?v=IrQQyWkFJwk)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture12.pdf) 
13. Further Contemporary RL Algorithms (DDPG, TD3, TRPO, PPO)
    * [Lecture video](https://www.youtube.com/watch?v=aYeDmT-y-4g)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Lecture13.pdf)

* Summary of Part One: Reinforcement Learning in Finite State and Action Spaces
    * [Lecture video](https://www.youtube.com/watch?v=bRpWfOSvMTg)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Summary_Part_One.pdf) 
* Summary of Part Two: Course Completion and Outlook
    * [Lecture video](https://www.youtube.com/watch?v=F_dkTOlVACM)
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/Summary_Part_Two.pdf) 
* Full course slides
    * [Lecture slides](https://groups.uni-paderborn.de/lea/share/lehre/reinforcementlearning/lecture_slides/built/main.pdf)


# Exercise Content
All exercises are based on Python 3.9 and site-packages according to the requirements.txt:
```
>>> pip install -r requirements.txt
```

01. Basics of Python for Scientific Computing 
    * [Tutorial video](https://www.youtube.com/watch?v=MJXVQXkOEAA&feature=youtu.be) (only 2022 edition available due to technical outage)
    * [Tutorial template](../master/exercises/templates/ex01)
    * [Tutorial solution](../master/exercises/solutions/ex01) 
02. Manually Solving Basic Markov Chain, Reward and Decision Problems
    * [Tutorial video](https://www.youtube.com/watch?v=d38-TmkEZxQ)
    * [Tutorial template](../master/exercises/templates/ex02)
    * [Tutorial solution](../master/exercises/solutions/ex02) 
03. The Beer-Bachelor and Dynamic Programming (the Shortest Beer Problem)
    * [Tutorial video](https://www.youtube.com/watch?v=Z9QTRtJfZaM&feature=youtu.be) (only 2022 edition available due to technical outage)
    * [Tutorial template](../master/exercises/templates/ex03)
    * [Tutorial solution](../master/exercises/solutions/ex03) 
04. Drive Through the Race Track with Monte Carlo Learning
    * [Tutorial video](https://www.youtube.com/watch?v=TSwWlfZXDWw)
    * [Tutorial template](../master/exercises/templates/ex04)
    * [Tutorial solution](../master/exercises/solutions/ex04) 
05. Drive even Faster Using Temporal-Difference Learning
    * [Tutorial video](https://www.youtube.com/watch?v=zXdyABW8Hb8)
    * [Tutorial template](../master/exercises/templates/ex05)
    * [Tutorial solution](../master/exercises/solutions/ex05) 
06. Stabilizing the Inverted Pendulum by Tabular Multi-Step Methods
    * [Tutorial video](https://www.youtube.com/watch?v=GwbfODvSpX8)
    * [Tutorial template](../master/exercises/templates/ex06)
    * [Tutorial solution](../master/exercises/solutions/ex06) 
07. Boosting the Inverted Pendulum by Integrating Learning & Planning (Dyna Framework)
    * [Tutorial video](https://www.youtube.com/watch?v=FvpIQN4mj2M)
    * [Tutorial template](../master/exercises/templates/ex07)
    * [Tutorial solution](../master/exercises/solutions/ex07) 
08. Predicting the Operating Behavior of a Real Electric Drive Systems with Supervised Learning
    * [Tutorial video](https://www.youtube.com/watch?v=Aivh5ykeJ2Q)
    * [Tutorial template](../master/exercises/templates/ex08)
    * [Tutorial solution](../master/exercises/solutions/ex08) 
09. Evaluate the Performance of Given Agents in the Mountain Car Problem Using Function Approximation 
    * [Tutorial video](https://www.youtube.com/watch?v=zCv29hVyxNk)
    * [Tutorial template](../master/exercises/templates/ex09)
    * [Tutorial solution](../master/exercises/solutions/ex09) 
10. Escape from the Mountain Car Valley Using Semi-Gradient Sarsa & Least Square Policy Iteration
    * [Tutorial video](https://www.youtube.com/watch?v=FrMSB7Dgp7c&feature=youtu.be)
    * [Tutorial template](../master/exercises/templates/ex10)
    * [Tutorial solution](../master/exercises/solutions/ex10) 
11. Improve the Value-Based Mountain Car Solution using Sarsa(Lambda)
    * [Tutorial video](https://www.youtube.com/watch?v=bhZGpuh5-6M)
    * [Tutorial template](../master/exercises/templates/ex11)
    * [Tutorial solution](../master/exercises/solutions/ex11) 
12. Landing on the Moon with REINFORCE and Actor-Critic Methods
    * [Tutorial video](https://www.youtube.com/watch?v=LeVDStyEjAo)
    * [Tutorial template](../master/exercises/templates/ex12)
    * [Tutorial solution](../master/exercises/solutions/ex12) 
13. Shoot to the moon with DDPG & PPO
    * [Tutorial video](https://www.youtube.com/watch?v=4RyX7L-MbsU)
    * [Tutorial template](../master/exercises/templates/ex13)
    * [Tutorial solution](../master/exercises/solutions/ex13) 

# Contributions
We highly appreciate any feedback and input to the course material e.g.
* typos or content-related discussions (please raise an issue)
* adding new contents (please provide a pull request)

If you like to contribute to the repo to a larger extent, please do not hesitate to contact us directly. 

# Credits
The lecture notes are inspired by
* [Richard S. Sutton, Andrew G. Barto, 'Reinforcement Learning: An Introduction' Second Edition MIT Press, Cambridge, MA, 2018](http://www.incompleteideas.net/book/the-book-2nd.html)
* [David Silver, UCL Course on Reinforcement Learning, 2015](https://www.davidsilver.uk/teaching/)

The tutorials are partly using pre-packed environments from
* [Gymnasium](https://gymnasium.farama.org/) (maintained branch of OpenAI's Gym)

# Citation
See "Cite this repository" on top


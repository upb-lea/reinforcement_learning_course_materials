# Reinforcement learning course

[![Build Status](https://github.com/upb-lea/reinforcement_learning_course_materials/actions/workflows/buildPDFs.yml/badge.svg)](https://github.com/upb-lea/reinforcement_learning_course_materials/actions/workflows/buildPDFs.yml)
[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![made-with-latex](https://img.shields.io/badge/Made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/)

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

Lecture notes, tutorial tasks including solutions as well as online videos for a reinforcement learning course originally hosted at Paderborn University and transferred to University of Siegen. Source code for the entire course material is open and everyone is cordially invited to use it for self-learning (students) or to set up your own course (lecturers).


## Lecture slides (click on preview picture)
<a href="https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf" target="_blank" class="image fit"><img src="misc/Lecture_preview.jpg" alt=""></a>

* Introduction to reinforcement learning
    * [Lecture video, part 1](https://www.youtube.com/watch?v=YqlNOCD0rfA)
    * [Lecture video, part 2](https://youtu.be/Yd99sn-64Z8)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec1)   
* Markov decision processes
    * [Lecture video](https://www.youtube.com/watch?v=ywn81iGQISE)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec2) 
* Dynamic programming
    * [Lecture video](https://www.youtube.com/watch?v=vjIiYdidFPY)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec3) 
* Monte Carlo methods
    * [Lecture video](https://www.youtube.com/watch?v=GBL0ArlONrM)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec4) 
* Temporal-difference learning
    * [Lecture video](https://www.youtube.com/watch?v=Rnf9Wanxnj8)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec5) 
* Multi-step bootstrapping
    * [Lecture video](https://www.youtube.com/watch?v=YYTSZTyjbQ4)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec6) 
* Planning and learning with tabular methods
    * [Lecture video](https://www.youtube.com/watch?v=gvJ3__GmHqo)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec7) 
* Function approximation with supervised learning
    * [Lecture video](https://www.youtube.com/watch?v=tXAxTiuvges)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec9) 
* On-policy prediction with function approximation
    * [Lecture video](https://www.youtube.com/watch?v=aA3MFRHrrtg)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec10) 
* Value-based control with function approximation
    * [Lecture video](https://www.youtube.com/watch?v=LE9dVVj5700)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec11) 
* Stochastic policy gradient methods
    * [Lecture video](https://www.youtube.com/watch?v=LzuZUyVr2mY)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec12) 
* Deterministic policy gradient methods
    * [Lecture video](https://www.youtube.com/watch?v=i6hOcGIgdoQ)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec13) 
* Further contemporary RL algorithms (TRPO, PPO)
    * [Lecture video](https://www.youtube.com/watch?v=H8rElrvs9Lo)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec14)
* Outlook and Research Insights
    * [Lecture video](https://www.youtube.com/watch?v=-TEzYSzXhW4)
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec15)
   

* Summary of part one: reinforcement learning in finite state and action spaces
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec7) 
* Summary of part two: reinforcement learning in continuous state and action spaces
    * [Lecture slides](https://upb-lea.github.io/reinforcement_learning_course_materials/lecture.pdf#sec16) 


# Exercise content
All exercises are based on Python 3.12 and site-packages according to the requirements.txt:
```
>>> pip install -r requirements.txt
```

01. Basics of Python for scientific computing 
    * [Tutorial video](https://www.youtube.com/watch?v=MJXVQXkOEAA&feature=youtu.be) (only 2022 edition available due to technical outage)
    * [Tutorial template](../master/exercises/templates/ex01)
    * [Tutorial solution](../master/exercises/solutions/ex01) 
02. Manually solving basic Markov chain, reward and decision problems
    * [Tutorial video](https://www.youtube.com/watch?v=JBliRPC_C5E&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=4)
    * [Tutorial template](../master/exercises/templates/ex02)
    * [Tutorial solution](../master/exercises/solutions/ex02) 
03. The beer-bachelor and dynamic programming (the shortest beer problem)
    * [Tutorial video](https://www.youtube.com/watch?v=5ylYfeWnb_Y&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=3)
    * [Tutorial template](../master/exercises/templates/ex03)
    * [Tutorial solution](../master/exercises/solutions/ex03) 
04. Drive through the race track with Monte Carlo learning
    * [Tutorial video](https://www.youtube.com/watch?v=RNV7px4AS_E&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=4)
    * [Tutorial template](../master/exercises/templates/ex04)
    * [Tutorial solution](../master/exercises/solutions/ex04) 
05. Drive even faster using temporal-difference learning
    * [Tutorial video](https://www.youtube.com/watch?v=5L3lhod1-CI&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=5)
    * [Tutorial template](../master/exercises/templates/ex05)
    * [Tutorial solution](../master/exercises/solutions/ex05) 
06. Stabilizing the inverted pendulum by tabular multi-step methods
    * [Tutorial video](https://www.youtube.com/watch?v=5k45M8ey_iw&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=6)
    * [Tutorial template](../master/exercises/templates/ex06)
    * [Tutorial solution](../master/exercises/solutions/ex06) 
07. Boosting the inverted pendulum by integrating learning & planning (Dyna framework)
    * [Tutorial video](https://www.youtube.com/watch?v=r9gLTDBzq5k&list=PL4GzQQuIDBGt82j99oDSWnjfrtwZ-79Yg&index=8)
    * [Tutorial template](../master/exercises/templates/ex07)
    * [Tutorial solution](../master/exercises/solutions/ex07) 
08. Predicting the operating behavior of a real electric drive systems with supervised learning
    * [Tutorial video](https://www.youtube.com/watch?v=Aivh5ykeJ2Q)
    * [Tutorial template](../master/exercises/templates/ex08)
    * [Tutorial solution](../master/exercises/solutions/ex08) 
09. Evaluate the performance of given agents in the mountain car problem using function approximation 
    * [Tutorial video](https://www.youtube.com/watch?v=AY7fvqnjmGU)
    * [Tutorial template](../master/exercises/templates/ex09)
    * [Tutorial solution](../master/exercises/solutions/ex09) 
10. Escape from the mountain car valley using semi-gradient SARSA & least square policy iteration
    * [Tutorial video](https://www.youtube.com/watch?v=IPxare_FmlE)
    * [Tutorial template](../master/exercises/templates/ex10)
    * [Tutorial solution](../master/exercises/solutions/ex10) 
11. Landing on the moon with REINFORCE and actor-critic methods
    * [Tutorial video](https://www.youtube.com/watch?v=dL6gK7ITVYU)
    * [Tutorial template](../master/exercises/templates/ex11)
    * [Tutorial solution](../master/exercises/solutions/ex11) 
12. Shoot for the moon with DDPG & PPO
    * [Tutorial video](https://www.youtube.com/watch?v=YpSC9lTQY4k)
    * [Tutorial template](../master/exercises/templates/ex12)
    * [Tutorial solution](../master/exercises/solutions/ex12) 

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

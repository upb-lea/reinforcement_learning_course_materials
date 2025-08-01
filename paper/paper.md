---
title: 'Reinforcement Learning: A Comprehensive Open-Source Course'
tags:
  - data science
  - Python
  - TensorFlow
  - PyTorch
  - Jupyter notebook
  - reproducible workflow
  - open science
  - reinforcement learning
  - exploratory data analysis
  - machine learning
  - supervised learning
authors:
  - name: Ali Hassan Ali Abdelwanis
    orcid: 0009-0001-5853-5900
    affiliation: 2
  
  - name: Barnabas Haucke-Korber
    orcid: 0000-0003-0862-2069
    affiliation: 1
    
  - name: Darius Jakobeit
    orcid: 0009-0002-1576-2465
    affiliation: 1
    
  - name: Wilhelm Kirchgässner
    orcid: 0000-0001-9490-1843
    affiliation: 1

  - name: Marvin Meyer
    orcid: 0009-0008-2879-7118
    affiliation: 1
    
  - name: Maximilian Schenke
    orcid: 0000-0001-5427-9527
    affiliation: 1
  
  - name: Hendrik Vater
    orcid: 0009-0005-0654-8741
    affiliation: 1
        
  - name: Oliver Wallscheid
    orcid: 0000-0001-9362-8777
    affiliation: 1

  - name: Daniel Weber
    orcid: 0000-0003-3367-5998
    affiliation: 1

affiliations:
 - name: Department of Power Electronics and Electrical Drives, Paderborn University, Germany
   index: 1
 - name: Department of Interconnected Automation Systems, University of Siegen, Germany
   index: 2

date: 19 July 2023
bibliography: paper.bib
---

# Summary

We present an open-source repository of an extensive course on reinforcement learning. It is specifically designed for master students in engineering and computer science. The course aims to introduce beginners to the fundamentals of reinforcement learning and progress towards advanced algorithms. This is done using examples spanning many different classic control engineering tasks. It is structured to be accessible to students with limited prior programming experience by introducing the basics of Python.

The course spans 14 weeks, comprising 14 lectures and 12 exercises. Accompanying video materials from real lectures and exercises are provided to aid in understanding the course content. They are available on a [YouTube channel](https://www.youtube.com/@uni_pb_lea/playlists) under an Creative Commons license. The open-source nature of the course allows other teachers to freely adapt the materials for their own teaching purposes. The primary goal is to equip learners with a solid theory of reinforcement learning principles, as well as the practical tools to solve real-world engineering problems from different domains, such as electrical engineering.

The lecture follows Richard S. Sutton and Andrew G. Barto's fundamentals book on reinforcement learning [@Sutton2005ReinforcementLA] and takes inspiration from the reinforcement learning lecture script delivered by David Silver [@silver2015]. The exercises are programmed in Python using Jupyter notebooks [@Kluyver2016jupyter] for presentation. Important libraries for machine and reinforcement learning are introduced, such as pandas [@reback2020pandas][@mckinney-proc-scipy-2010], gymnasium [@towers_gymnasium_2023], PyTorch [@NEURIPS2019_9015], scikit-learn [@sklearn_api], and stable-baselines3 [@stable-baselines3]. 

The authors of this course have experience working with reinforcement learning in the domain of electrical engineering, in particular in electric drive [@deep_q_torque] and grid control [@10182718]. The course has first been held under the constraints of the Corona pandemic in 2020, resorting to an online, asynchronous learning experience. It has been extended with a session on more contemporary algorithms in 2022. In subsequent years the course has been revised to incorporate experience from teaching the course and to align the structure of the exercises. All versions (for each year's revision) are available inside the publicly available [GitHub repository](https://github.com/upb-lea/reinforcement_learning_course_materials).

# Statement of Need

Recent developments in (deep) reinforcement learning caused considerable excitement in both, academia as well as [popular science media](https://www.youtube.com/watch?v=WXuK6gekU1Y). Starting with beating champions in complex board games such as chess [@chess] and Go [@SilverHuangEtAl16nature], breaking human records in a wide variety of video games [@atari-first] [@starcraft2], up to recent solutions in real-world (control) applications [@robotics] [@rlhf] [@motors] [@zejnullahu2022applications] [@CORONATO2020101964] [@traffic], reinforcement learning agents have been proven to be a control or decision-making solution for a wide variety of application domains. Reinforcement learning poses an elegant and data-driven path to a control solution with minimal expert knowledge involved, which makes it highly attractive for many different research domains. A similar development has already been observed in recent years with regard to deep supervised learning. 

An increasing amount of educational resources is available due to the traction RL has gained in recent years. However, most courses lack either the continuity of topics ranging from the foundations up to the advanced topics of deep reinforcement learning, practical programming exercises accompanying each theoretical lecture, the testing at university level, or free availability. Alternative courses often focus on games ^[https://huggingface.co/learn/deep-rl-course/unit0/introduction] or a mix of theoretical and practical questions for their exercises ^[https://web.stanford.edu/class/cs234/] ^[https://spinningup.openai.com/en/latest/]. In contrast, our course utilizes practical application scenarios from a wide variety of domains with a strong focus on classical control engineering tasks. This course can therefore help accelerate establishing reinforcement learning solutions within real-world applications.


# Target Audience and Learning Goals

The target learner audience of this course are master students from the subjects of engineering, computer science and anyone who is interested in the concepts of reinforcement learning. Its exercises are designed to be solvable by students without (strong) programming background when done in the presented order. Students learn to utilize reinforcement learning depending on the problem. They learn how to incorporate expert knowledge into their reinforcement learning solution, e.g., by designing the features or reward functions. Exercises start with a very low-level introduction of the programming language Python. Later exercises introduce advanced techniques that can be utilized in more comprehensive environments, such as electric drive states prediction or vehicle control. Students should have experience with algorithm notation to be able to practically implement the algorithms which are presented in the lectures. Some basic understanding of stochastics is advised to understand mathematical background. At the end of the course, students should have gained the following skills:

* Understand basic concepts and functionalities of reinforcement learning methods.
* Be able to understand and evaluate state-of-the-art algorithms.
* Have the ability to implement basic and advanced algorithms using open-source libraries in Python.
* Be able to select a fitting solution when presented with a new task.
* Can critically interpret and evaluate results and performance.

# Content

The course is structured as a one semester university-level course with two sessions each week: one lecture and one exercise. The contents of the latest iteration of the course (summer term 2025) are presented in the following.

A summary of lectures and exercises can be found in table 1 and table 2, respectively.

Table: Summary of course lectures.

| Lecture | Content |
|---:|---------|
| 01 | Introduction to Reinforcement Learning |
| 02 | Markov Decision Processes |
| 03 | Dynamic Programming |
| 04 | Monte Carlo Methods |
| 05 | Temporal-Difference Learning |
| 06 | Multi-Step Bootstrapping |
| 07 | Planning and Learning with Tabular Methods |
| 08 | Function Approximation with Supervised Learning |
| 09 | On-Policy Prediction with Function Approximation |
| 10 | Value-Based Control with Function Approximation |
| 11 | Stochastic Policy Gradient Methods |
| 12 | Deterministic Policy Gradient Methods  |
| 13 | Further Contemporary RL Algorithms (TRPO, PPO) |
| 14 | Outlook and Research Insights |


Table: Summary of course exercises.

|Exercise|Content |
|---:|-----------------------|
| 01 | Basics of Python for Scientific Computing |
| 02 | Basic Markov Chain, Reward and Decision Problems |
| 03 | Dynamic Programming |
| 04 | Race Track with Monte Carlo Learning |
| 05 | Race Track with Temporal-Difference Learning |
| 06 | Inverted Pendulum with Tabular Multi-Step Methods |
| 07 | Inverted Pendulum within Dyna Framework |
| 08 | Predicting Electric Drive with Supervised Learning |
| 09 | Evaluate Given Agents in Mountain Car Problem |
| 10 | Mountain Car Valley Using Semi-Gradient Sarsa |
| 11 | Moon Landing with Actor-Critic Methods |
| 12 | Shoot for the moon with DDPG & PPO |

Lectures and exercises which share the same number also deal with the same topics. Thus, theoretical basics are provided in the lecture, which are to be implemented and evaluated in the exercises on the basis of specific application examples which are lend from third party open-source libraries [@gym][@towers_gymnasium_2023]. This allows the learners to internalize learned contents practically. However, the lecture can be studied independently of the exercises and the exercises independently of the lecture in case of self-learning.

The lecture slides were created in LaTex and published accordingly to allow for consistent display and easy adaptation of the material by other instructors. The practical exercises were implemented in Jupyter notebooks [@Kluyver2016jupyter]. These also allow a quick implementation of further, or modification of existing, content.

# Conclusion

The presented course provides a complete introduction to the fundamentals and contemporary applications of reinforcement learning. By combining theory and practice, the learner is enabled to analyze and solve (even intricate control engineering) problems in the context of reinforcement learning. Both, the lecture content and the exercises, are open-source and designed to be easily adapted by other instructors. Due to the recorded explanatory videos, this course can easily be used by self-learners.

# Author's Contribution

Authors are listed in alphabetical order. Wilhelm Kirchgässner, Maximilian Schenke, Oliver Wallscheid, and Daniel Weber have created and held this course since the summer term of 2020. Barnabas Haucke-Korber, Darius Jakobeit, and Marvin Meyer joined the University of Paderborn at a later date and supported with revising and holding the exercises in 2023. In 2024, Hendrik Vater contributed by aligning the exercises to a common format. In 2025, Ali Hassan Ali Abdelwanis supported updating the exercises to the newest libraries and contributed to their revision.

# Acknowledgements 

We would like to thank all of the students who helped improving the course by attending lectures, solving the exercises and giving valuable feedback, as well as the open-source community for asking questions and suggesting changes on GitHub.

# References
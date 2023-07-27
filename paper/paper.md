---
title: '"Unveiling Reinforcement Learning: A Comprehensive Open-Source Course'
tags:
  - data science
  - Python
  - Tensroflow
  - Pytorch
  - Jupyter notebook
  - reproducible workflow
  - open science
  - reinforcement learning
  - exploratory data analysis
  - machine learning
  - supervised learning
authors:
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
        
  - name: Oliver Wallscheid
    orcid: 0000-0001-9362-8777
    affiliation: 1

  - name: Daniel Weber
    orcid: 0000-0003-3367-5998
    affiliation: 1

affiliations:
 - name: Department of Power Electronics and Electrical Drives, Paderborn University, Germany
   index: 1

date: 19 July 2023
bibliography: paper.bib
---

# Summary

Unveiling Reinforcement Learning is an open-source repository of an extensive course on Reinforcement Learning. It is specifically designed for master's students in electrical engineering, computer engineering, and computer science. The course aims to introduce beginners to the fundamentals of reinforcement learning and progress towards advanced algorithms. This is done using examples spanning from games to control engineering tasks. It is structured to be accessible to students without prior programming experience.

The course spans 14 weeks, comprising 14 lectures and 12 exercises. Accompanying video materials from real lectures and exercises are provided to aid in understanding the course content. They are available on the departments' YouTube channel under an open source license. The open-source nature of the course allows other teachers to freely adapt the materials for their own teaching purposes. The primary goal is to equip learners with a solid theory of reinforcement learning principles, as well as the practical tools to solve real-world problems from different domains such as electrical engineering.

The lecture follows Richard S. Sutton and Andrew G. Barto's fundamentals book on Reinforcement Learning and takes inspiration from the Reinforcement Learning lecture script delivered by David Silver. The exercises are programmed in the Python ecosystem using Jupyter notebooks for presentation. Important libraries for machine and reinforcement learning are introduced such as pandas, gymnasium, tensorflow and pytorch. 

The authors of this course have scientifical experience working with reinforcement learning in the domain of electrical engineering, in particular in power electronics and electrical drive technology. The course has first been held under the constraints of the Corona pandemic in 2020 resorting to an online, asynchronous learning experience. It has been extended with a session of more advanced reinforcement learning algorithms in 2022. In 2023, it has been re-worked to incorporate student feedback and allow for a better synchronous experience. Both versions (2023 and prior) are available inside the open-source repository.

# Statement of need

Recent developments in (deep) reinforcement learning have made waves in both the academic and public worlds. Starting with beating champions in complex brain games like chess and Go, breaking human records in a wide variety of video games, to recent solutions in real-world (control) applications, reinforcement learning agents have proven to be a general-purpose solution for a wide variety of application domains. It has therefore become inevitable for many domains to deal with the topic of reinforcement learning. A similar development has already been observed in recent years with regard to deep supervised learning. This course is therefore aimed at two different target groups: On the one hand, interested learners who still lack (partial) knowledge about the topic or the application of reinforcement learning and, on the other hand, teachers who are looking for a starting point for their teaching materials. 

While the course was designed to be easily followable by computer science, computer engineering, and electrical engineering students, it is applicable to other disciplines as well. Exercises start with a very low-level introduction of the programming language Python. Later exercises introduce more complex techniques to allow for more complex applications. The application examples chosen are from a wide variety of domains and can easily be exchanged by other instructors, as the reinforcement learning methods are general-purpose. This course can therefore help accelerate the transition of reinforcement learning into real-life applications and thus accelerate automation and progress.


# Target audience and learning goals

The target learner audience of this course are master students from the subjects of electrical engineering, computer engineering and computer science or anyone who is interested in the concepts of reinforcement learning. It's exercises are designed to be solvable by students without programming background when done in the presented order. Students should be able to read pseudocode to be able to practically implement the algorithms which are presented in the lectures. Some basic understanding of stochastics is also desired to understand mathematical notations. At the end of the course, students should have gained the following skills:

* Understand basic concepts and functionalities of reinforcement learning algorithms
* Be able to research and understand state of the art algorithms
* Have the ability to implement basic and advanced algorithms using open source libraries in Python
* Are able to select a fitting algorithm when presented with a new task
* Can critically interpret and evaluate algorithmic results and performance

# Content

The course is structured as an one semester university course with two sessions each week: one lecture and one exercise for each week. This chapters will list the contents of the 2023 version of the course.

A summary of the lectures can be found in Table 1, a summary of the excersises in Table 2 below:

Table: Summary of course lectures.

| Lecture | Content | Slides | Video |
|---------|---------|------------------------|-------------------------|
| 01    | Introduction to Reinforcement Learning |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture01.tex)|[YouTube](https://www.youtube.com/watch?v=YqlNOCD0rfA)|
| 02    | Markov Decision Processes |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture02.tex) |[YouTube](https://www.youtube.com/watch?v=ywn81iGQISE)|
| 03    | Dynamic Programming |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture03.tex) |[YouTube](https://www.youtube.com/watch?v=vjIiYdidFPY)|
| 04    | Monte Carlo Methods |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture04.tex) |[YouTube](https://www.youtube.com/watch?v=GBL0ArlONrM)|
| 05    | Temporal-Difference Learning |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture05.tex)|[YouTube](https://www.youtube.com/watch?v=Rnf9Wanxnj8)|
| 06    | Multi-Step Bootstrapping |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture06.tex) |[YouTube](https://www.youtube.com/watch?v=YYTSZTyjbQ4)|
| 07    | Planning and Learning with Tabular Methods |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture07.tex) |[YouTube](https://www.youtube.com/watch?v=gvJ3__GmHqo)|
| 08    | Function Approximation with Supervised Learning |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture08.tex) |[YouTube](https://www.youtube.com/watch?v=tXAxTiuvges)|
| 09    | On-Policy Prediction with Function Approximation |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture09.tex)|[YouTube](https://www.youtube.com/watch?v=aA3MFRHrrtg)|
| 10   | Value-Based Control with Function Approximation |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture10.tex)|[YouTube](https://www.youtube.com/watch?v=LE9dVVj5700)|
| 11   | Stochastic Policy Gradient Methods |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture11.tex)|[YouTube](https://www.youtube.com/watch?v=LzuZUyVr2mY)|
| 12   | Deterministic Policy Gradient Methods  |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture12.tex)|[YouTube](https://www.youtube.com/watch?v=i6hOcGIgdoQ)|
| 13   | Further Contemporary RL Algorithms (TRPO, PPO) |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture13.tex)|[YouTube](https://www.youtube.com/watch?v=H8rElrvs9Lo)|
| 14   | Outlook and Research Insights |[LaTex](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/lecture_slides/tex/Lecture14.tex)|[YouTube](https://www.youtube.com/watch?v=-TEzYSzXhW4)|


Table: Summary of course exercises.

| Exercise | Content | Exercise | Solution | Video |
|------|---------------------------------|-----------|----------|----------|
| 01    | Basics of Python for Scientific Computing |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex01)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex01)|[YouTube](https://www.youtube.com/watch?v=MJXVQXkOEAA&feature=youtu.be)|
| 02    | Manually Solving Basic Markov Chain, Reward and Decision Problems |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex02)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex02)|[YouTube](https://www.youtube.com/watch?v=d38-TmkEZxQ)|
| 03    | The Beer-Bachelor and Dynamic Programming (the Shortest Beer Problem) |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex03)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex03)|[YouTube](https://www.youtube.com/watch?v=Z9QTRtJfZaM&feature=youtu.be)|
| 04    | Drive Through the Race Track with Monte Carlo Learning |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex04)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex04)|[YouTube](https://youtu.be/TSwWlfZXDWw)|
| 05    | Drive even Faster Using Temporal-Difference Learning |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex05)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex05)|[YouTube](https://youtu.be/zXdyABW8Hb8)|
| 06    | Stabilizing the Inverted Pendulum by Tabular Multi-Step Methods |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex06)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex06)|[YouTube](https://www.youtube.com/watch?v=GwbfODvSpX8)|
| 07    | Boosting the Inverted Pendulum by Integrating Learning & Planning (Dyna Framework) |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex07)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex07)|[YouTube](https://www.youtube.com/watch?v=FvpIQN4mj2M)|
| 08    | Predicting the Operating Behavior of a Real Electric Drive Systems with Supervised Learning |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex08)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex08)|[YouTube](https://www.youtube.com/watch?v=Aivh5ykeJ2Q)|
| 09    | Evaluate the Performance of Given Agents in the Mountain Car Problem Using Function Approximation |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex09)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex09)|[YouTube](https://www.youtube.com/watch?v=AY7fvqnjmGU)|
| 10    | Escape from the Mountain Car Valley Using Semi-Gradient Sarsa & Least Square Policy Iteration |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex10)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex10)|[YouTube](https://www.youtube.com/watch?v=IPxare_FmlE)|
| 11    | Landing on the Moon with REINFORCE and Actor-Critic Methods |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex11)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex11)|[YouTube](https://www.youtube.com/watch?v=dL6gK7ITVYU)|
| 12    | Shoot for the moon with DDPG & PPO |[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/templates/ex12)|[Notebook](https://github.com/upb-lea/reinforcement_learning_course_materials/blob/master/exercises/solutions/ex12)|[YouTube](https://www.youtube.com/watch?v=YpSC9lTQY4k)|

Lectures and exercises, which share the same number, deal with the same topics. Thus, theoretical foundations are laid in the lecture, which are to be implemented and evaluated in the exercises on the basis of concrete application examples. This allows the learners to internalize learned contents practically. However, the lecture can be studied without the exercises and the exercises without the lecture in case of self-learning.

The lecture slides were created in LaTex and published accordingly to allow for consistent display and easy adaptation of the material by other instructors. The practical exercises were implemented in jupyter notebooks. These also allow a quick implementation of further, or modification of existing, content. When creating the exercises, first the exercises were created from the solutions using nbgrader.

# Experience of use

Master students of University Paderborn from the subjects of electrical engineering, computer engineering and computer science were allowed to enroll to this course, as well as students who wanted to take this course as studium generale. Prior to 2023, students were given the learning materials along with the explainer videos so that they could use the material in a self-learning manner. In addition, synchronous appointments were offered for students to ask their questions about the lecture and exercise content. This method was chosen to adapt to the teaching conditions of the Corona pandemic. Then, at the wish of the students, the course was restructured in 2023 to be taught in a classical, synchronous manner. Every week one lecture and one exercise were held. The exercise meetings took place one week after the corresponding lecture to give the students time to implement the exercise themselves. Then, in the exercise meetings, the solution was presented by an instructor, for example by solving or discussing the programming tasks live and evaluating and interpreting the results. In addition, the synchronous lectures and exercises were recorded and published. This allowed students to review content or catch up on missed content. Since all units were recorded in videos, the course is perfectly suitable for self-learning.

# Conclusion

The presented course provides a complete introduction to the fundamentals and advanced algorithms of reinforcement learning. By combining theory and practice, the learner is enabled to analyze and solve even complex engineering applications in the context of reinforcement learning. Both the lecture content and the exercises are open source and designed to be easily adapted by other instructors. Due to the recorded explanatory videos, this course can also be used as by self-learners.

# Author's Contribution

Authors are listed in alphabetical order. All authors are affiliated with the University Paderborn. Wilhelm Kirchgässner, Maximilian Schenke, Oliver Wallscheid and Daniel Weber have designed and held this course at the very beginning in 2020. Barnabas Haucke-Korber, Darius Jakobeit and Marvin Meyer joined the University Paderborn at a later date and helped in redesigning the exercises in 2023. 

# Acknowledgements 

We would like to acknowledge all PhD student demonstrators who helped with teaching the material and creating assignments. We would also like to thank all of the students who helped improving the course by attending lectures, solving the exercises and giving valuable feedback, as well as the open source community for rising issues.

# References
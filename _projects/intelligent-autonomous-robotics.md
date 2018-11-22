---
name: Intelligent Autonomous Robotics
type: University Project
image: iar.jpg
link: "https://github.com/AngusP/Khepera-II-IAR"
date: 2016-11-29
---

This task is inspired by ant navigation capabilities. The robot starts at a *'nest'* and must
search for virtual *'food'* in the environment, collect it and return it to the nest to gain points.

We imlemented Simultaneous Localisation and Mapping (SLAM) in the 2D environment
with the [Khepera II Robot](https://www.k-team.com/mobile-robotics-products/old-products/khepera-ii),
choosing to evolve a map as the robot explores rather than use a pre-configured static map.

This project was implemented using Python, Redis and ROS. The above image has the real Rviz (ROS)
representation of the robot's state in that environment superimposed.

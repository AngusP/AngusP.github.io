---
title: SDP Firmware
layout: post
hero: 2016-04-15-sdp-hero.jpg
---

Preamble
========

SDP is Edinburgh University's third year Computer Sicence System Design project. The task is to build and develop a robot to play two-a-side footbal loosely based on the rules of the [RoboCup SSL](https://en.wikipedia.org/wiki/RoboCup_Small_Size_League). Teams have 10 members in two groups, one per robot. The System architecture, at an abstract level, is comprised of a vision system, strategy AI/planner, computer-to-robot communications module and of course the robot with it's hardware and firmware.

Tasks for developing the system were divided up between the ten people in the team, and I took building the code that runs on the Arduino. Provided hardware was the Xino RF, an Arduino clone with the familiar AT328P microcontroller and an added Ciseco SRF chip, for wireless communications to the C&C computer that'd be running the rest of the stack.

Holonomics are fun
==================

Our group settled on a three wheeled holonomic design pretty early on - motivations for this were mainly "Because it's cool", "Angus wants to do holonomics" and also because some people in the year above strongly suggested that we *didnt't* make a holonomic robot.

The maths behind holonomics isn't actually all that complex - it comes from doing the mechanics on the three forces produced by the three wheels, and the observation that what we're really dealing with is a matrix.

<figure>
<img src="/media/2016-04-15-holo-mech.jpg" 
     alt="Three wheel holonomics mechanical diagram"
     style="width: 400px;">
</figure>



Doing more than one thing
=========================

It's pretty important that the bot can perform more than one task at a time - commands could be coming in from strategy, and there's a host of things we need to do, like reading sensors at steady intervals and performing error corrections. 

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

<figure class="row">
  <div class="col center">
    <img src="/media/2016-04-15-holo-mech.jpg" 
         alt="Three wheel holonomics mechanical diagram"
         style="width: 400px;">
  </div>
  <div class="col">
    <p>
      The three forces produced by the wheels, F<sub>1</sub> through to F<sub>3</sub>. Simple trigonometry splits these forces into their <i>x,y</i> components.
    </p>
  </div>
</figure>

So, we have the following:

<figure>
  \[
  F_x = F_1 \cdot \cos(\Theta_1 + \frac{\pi}{2}) + F_2 \cdot \cos(\Theta_2 + \frac{\pi}{2}) + F_3 \cdot \cos(\Theta_3 + \frac{\pi}{2})
  \]

  \[
  F_y = F_1 \cdot \sin(\Theta_1 + \frac{\pi}{2}) + F_2 \cdot \sin(\Theta_2 + \frac{\pi}{2}) + F_3 \cdot \sin(\Theta_3 + \frac{\pi}{2})
  \]
</figure>

Which, is equivalent to the following **Force Coupling** matrix: (Note the omega is the rotational force)

<figure>
  \begin{pmatrix}
      F_1 \\
      F_2 \\
      F_3
  \end{pmatrix} = \begin{pmatrix}
      -\frac{1}{2} & \frac{\sqrt{3}}{2} & 1\\
      -\frac{1}{2} & -\frac{\sqrt{3}}{2} & 1\\
      1 & 0 & 1
  \end{pmatrix} \begin{pmatrix}
      F_x \\
      F_y \\
      \omega
  \end{pmatrix}
</figure>

Doing more than one thing
=========================

It's pretty important that the bot can perform more than one task at a time - commands could be coming in from strategy, and there's a host of things we need to do, like reading sensors at steady intervals and performing error corrections. 

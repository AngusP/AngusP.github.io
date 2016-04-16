---
title: SDP Firmware
layout: post
hero: 2016-04-15-sdp-hero.jpg
---

Preamble
========

SDP is Edinburgh University's third year Computer Science System Design project. The task is to build and develop a robot to play two-a-side football loosely based on the rules of the [RoboCup SSL](https://en.wikipedia.org/wiki/RoboCup_Small_Size_League). Teams have 10 members in two groups, one per robot. The System architecture, at an abstract level, is comprised of a vision system, strategy AI/planner, computer-to-robot communications module and of course the robot with it's hardware and firmware.

Tasks for developing the system were divided up between the ten people in the team, and I took building the code that runs on the Arduino. Provided hardware was the Xino RF, an Arduino clone with the familiar AT328P microcontroller and an added Ciseco SRF chip, for wireless communications to the C&C computer that'd be running the rest of the stack.

Holonomics are fun
==================

Our group settled on a three wheeled holonomic design pretty early on - motivations for this were mainly "Because it's cool", "Angus wants to do holonomics" and also because some people in the year above strongly suggested that we *didnt't* make a holonomic robot. Holonomic wheels have bearings that let the wheel slide laterally along it's axis of rotation, giving freedom of movement in any direction if used correctly.

The maths behind holonomics isn't actually all that complex - it comes from doing the mechanics on the three forces produced by the three wheels, and the observation that what we're really dealing with is a matrix.

<figure class="row">
  <div class="col center">
    <img src="/media/2016-04-15-holo-mech.jpg" 
         alt="Three wheel holonomics mechanical diagram"
         style="width: 400px;">
  </div>
  <div class="col">
    <p>
      The three forces produced by the wheels, F<sub>1</sub> through to F<sub>3</sub>.
    </p>
    <p>
      Simple trigonometry splits these forces into their <i>x,y</i> components.
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
  \[
  \begin{pmatrix}
      F_1 \\
      F_2 \\
      F_3
  \end{pmatrix}
  =
  \begin{pmatrix}
      -\frac{1}{2} & \frac{\sqrt{3}}{2} & 1\\
      -\frac{1}{2} & -\frac{\sqrt{3}}{2} & 1\\
      1 & 0 & 1
  \end{pmatrix}
  \begin{pmatrix}
      F_x \\
      F_y \\
      \omega
  \end{pmatrix}
  \]
</figure>

This translation between forward, lateral & rotational force and the application of power is done in firmware, meaning the rest of the stack needn't be aware of the specifics of this bot; Three wheel holonomic or otherwise. While the single-precision floating point we're limited to on the Arduino (`double` is a lie) makes this tricky, in practice using unit vectors and a separate magnitude multipliers prevents `NaNs` from ruining our day.

Error correcting on the fly
---------------------------

While holonomics are a powerful advantage, giving the ability to move in any direction and rotate as we wish independently of each-other, this all depends on us being able to move the motors in perfect proportions to the holonomic forces we've derived.

It's also *not* sufficient to try correcting linearly, nor is it particularly clever to guess at some function that'll do this correction for you. A full PID controller is overkill in this situation, and we employed a Gradient Descent algorithm to do these corrections during runtime, using the feedback from the rotary encoders Lego's NXT motors are equiped with.

So, without further ado, the correction maths on the robot: The error vector $$\hat{e}$$ given a desired velocity vector (The one we get sent over the RF link) $$\hat{v}$$ and realised velocity vector $$\hat{r}$$ (the one we read from the rotary encoders) is:

<figure>
  \[
  \hat{e_i} = k \cdot \frac{\hat{d_i}}{||\hat{d}||}
  \]
</figure>

$$k$$ is the learning rate, which increases the granularity with which we'll correct, hopefully resulting in a smooth correction with no over-reactions. Tuning this constant has the greatest effect on how the corrective system behaves; We used a value of around 0.1, which is quite conserative but very smooth.

The new powers we need to apply to the motors to reduce the error, $$\hat{c'}$$, with respect to the previous $$\hat{c}$$ and error $$\hat{e}$$ is

<figure>
  \[
  \hat{c_i}' = \frac{ \hat{c_i} }{||\hat{c}||} + \frac{ \hat{e_i} }{||\hat{e}||}
  \]
</figure>

Note that we're operating on unit vectors here - that prevents the need to consider the units we're working in, some of which would take a large amount of unecessary computation to figure out. After we're done correcting, a stored power multiplier scales the corrected unit vector back up.

So, the error function we need to minimise, $$E$$, is as follows: (bit of a maths jump, it's just the size of $$\hat{e}$$)

<figure>
  \[
  E_{(\hat{d},\hat{r})} = \sqrt{\sum_{j=1}^{n} (\hat{d_j} - \hat{r_j})^2}
  \]
</figure>

Finally, for Gradient Descent correction we need the partial derivative of $$E$$ with respect to $$\hat{r}$$

<figure>
  \[
  \frac{\partial E}{\partial \hat{r_i}}
  =
  \frac{\hat{r_i} - \hat{d_i}}{\sqrt{\sum_{j=1}^{n} (\hat{d_j} - \hat{r_j})^2}}
  =
  \frac{\hat{r_i} - \hat{d_i}}{||\hat{d}-\hat{r}||}
  \]
</figure>

And the result of all this fiddling looks like this: (warning: **Loud** ungodly NXT noise)

<figure class="center iframe-responsive">
  <iframe src="https://www.youtube.com/embed/xdrMzdQxG6U?rel=0&amp;controls=0&amp;showinfo=0"
          frameborder="0" allowfullscreen></iframe>
</figure>

---

Doing more than one thing
=========================

It's pretty important that the bot can perform more than one task at a time - commands could be coming in from strategy, and there's a host of things we need to do, like reading sensors at steady intervals and performing error corrections.



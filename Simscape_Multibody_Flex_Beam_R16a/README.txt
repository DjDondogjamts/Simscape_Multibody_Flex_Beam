Run startup_Flexible_Beam_Demo.m to get started
This will open up Flexible_Beam_Compare.slx model and a web demo script. 

The model describes two approaches for modeling flexible bodies using an 
example of a hollow square beam. 
1. Lumped parameter approach: 
   Flexible body is modeled as a chain of rigid body-spring-dampers.

2. State-space approach: 
   Flexible body is modeled by superimposing deflection of flexible beam
   onto rigid body motion.  Deflection of flexible beam is calculated
   using a state-space model that represents the eigenmodes.

Configuration:
You can change the wall boundary conditions for the beam (rigidly attached 
to wall or through a revolute joint) as well as load condition (rigid bob 
or a pendulum link) by double clicking on the respective subsystems in the
model

There are number of other models in this demonstration that can be easily
accessed from the web demo script.
1. Flexible_Beam_LP_Simple.slx: 
   Simplest version of a flexible cantilver beam modeled 
   using lumped parameter approach. You can analyze the beam 
   for static deflection, modes and mode shapes.

2. Flexible_Beam_LP.slx: 
   Also lumped parameter approach. Beam model has inputs and outputs
   such that a state-space model can be extracted that accounts for
   distributed loads on the beam. 

3. Compare_Flexible_Cantilever_SS_Full_Reduced.slx: 
   Compares full state space with balred reduced state space model. 
   

Copyright 2014-2016 The MathWorks, Inc.


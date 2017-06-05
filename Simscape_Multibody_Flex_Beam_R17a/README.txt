Basic components and examples for modeling flexible beams.
Copyright 2014-2017 The MathWorks, Inc.

Run startup_Flexible_Beam_Demo.m to get started
This will open up Flexible_Beam_Compare.slx model and a web demo script. 

The model describes two approaches for modeling flexible bodies using an 
example of a hollow beam. 

1. Lumped parameter approach: 
   Flexible body is modeled as a chain of rigid body-spring-dampers.
   Stiffness and damping is calculated using beam theory as a function
   of cross-section and beam material.

2. State-space approach: 
   Flexible body is modeled by superimposing deflection of flexible beam
   onto rigid body motion.  Deflection of flexible beam is calculated
   using a state-space model that represents the eigenmodes.

Configuration:
You can change the wall boundary conditions for the beam (rigidly attached 
to wall or through a revolute joint) as well as load condition (rigid bob 
or a pendulum link) by clicking on hyperlinks in the model.

There are number of other models in this demonstration that can be easily
accessed from the web demo script.
1. Flexible_Beam_LP_Modes.slx: 
   Simplest version of a flexible cantilver beam modeled 
   using lumped parameter approach. You can analyze the beam 
   by calculating static deflection, natural frequencies, and mode shapes.

2. Flexible_Beam_LP_Modes_GenSS.slx: 
   Also lumped parameter approach. Beam model has inputs and outputs
   such that a state-space model can be extracted that accounts for
   distributed loads on the beam. 

3. Flexible_Beam_SS_Full_Reduced.slx
   Compares full state space with balred reduced state space model. 
   
4. Flexible_Beam_SS_Static_Deflection.slx
   Shows that state-space method can handle distributed load (gravity)
   for limited configurations. 
 


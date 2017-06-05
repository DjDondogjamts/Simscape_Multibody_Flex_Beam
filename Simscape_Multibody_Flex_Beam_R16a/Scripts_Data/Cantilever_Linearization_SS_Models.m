%%
% Copyright 2014-2016 The MathWorks, Inc.
%
% CALCULATE LINEAR SS MODELS (FULL & BALRED REDUCED)FOR TWO CONFIGURATIONS 
% OF CANTILEVER BEAM
% 1. RIGID ATTACHMENT TO WALL
% 2. PENDULUM (REVOLUTE ATTACHEMENT TO WALL )
% ENSURE DAMPING IS HUGE FOR FAST SIMULATION (BY DEFAULT ITS SET TO 1E7)
% IF OSCILLATIONS ARE IMPORTANT, KEEP THE DAMPING TO A LOW VALUE OF 1

% LOAD THE SYSTEM
mdl = bdroot;
open_system(mdl)
load_system('FlexBeamElement_MS2G_Lib')

% SETUP THE MODEL FOR LINEARIZATION
set_param('FlexBeamElement_MS2G_Lib', 'Lock', 'off');
set_param('FlexBeamElement_MS2G_Lib/Flex_Element','BlockChoice','Bend')
set_param(mdl,'SimulationCommand','update')
sys_io = getlinio(mdl);             % FIND INPUTS AND OUTPUTS
reduced_states = 6;

% LINEARIZE THE MODEL FOR 1ST CONFIGURATION OF RIGID ATTACHMENT TO WALL
disp('Calculating Cantilever State-Space Model')
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');
linsys_beam_fixfree = linearize(mdl,sys_io);    % OBTAIN LINEAR MODEL
linsys_beam_fixfree_reduced = balred(linsys_beam_fixfree,reduced_states);
disp('Cantilever State-Space Model Created')

% LINEARIZE THE MODEL FOR 2ND CONFIGURATION OF PENDULUM
disp('Calculating Pendulum State-Space Model')
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Rotate');
linsys_beam_rotfree = linearize(mdl,sys_io);    % OBTAIN LINEAR MODEL
linsys_beam_rotfree_reduced = balred(linsys_beam_rotfree,reduced_states);
disp('Pendulum State-Space Model Created')

% CLOSE THE LIBRARY MODEL
close_system('FlexBeamElement_MS2G_Lib',0)
%%
% close_system(mdl,0)

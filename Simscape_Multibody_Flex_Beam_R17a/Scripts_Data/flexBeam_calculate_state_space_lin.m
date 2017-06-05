% Calculate linear state-space models (full and balred reduced) for two
% configurations of the beam.
% 1. Cantilever with one fixed end, one free end
% 2. Pendulum (rotation at one end, one free end)
%
% For fast simulation set damping high (for example 1e7)
% If oscillations are important, keep damping low (for example 1)

% Copyright 2014-2017 The MathWorks, Inc.

% Save current damping value
Damping_temp = Damping;
Damping = 1e7;

% Load the system
mdl = bdroot;
open_system(mdl)

% Save current flexibility configuration
temp_ftype = get_param([mdl '/Flex_Body'],'radio_flextype');
set_param([mdl '/Flex_Body'],'radio_flextype','1-Axis Bending')

% Configure the model for linearization
set_param(mdl,'SimulationCommand','update')

% Find inputs and outputs
sys_io = getlinio(mdl);             
reduced_states = 6;

% Linearize model in first configuration (fixed end, free end)
disp('Calculating Cantilever State-Space Model')
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');
% Obtain linear model
linsys_beam_fixfree = linearize(mdl,sys_io);    
linsys_beam_fixfree_reduced = balred(linsys_beam_fixfree,reduced_states);
disp('Cantilever State-Space Model Created')

% Linearize model in second configuration (pendulum)
disp('Calculating Pendulum State-Space Model')
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Rotate');
% Obtain linear model
linsys_beam_rotfree = linearize(mdl,sys_io);
linsys_beam_rotfree_reduced = balred(linsys_beam_rotfree,reduced_states);
disp('Pendulum State-Space Model Created')

% Reset damping and flexibility type to original values
Damping = Damping_temp;
set_param([mdl '/Flex_Body'],'radio_flextype',temp_ftype)


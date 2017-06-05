% Default beam parameters
% Copyright 2014-2017 The MathWorks, Inc.

density = 7850;     % Density (Steel)
youngsM = 200E9;	% Modulus of Elasticity (Steel)
shearM = 80E9;      % Shear Modulus (Steel)
Damping = 1e7;      % Damping Coefficient (high for deflection test)
gravity = [0 -9.80665 0];  % -Y for test

% BEAM DIMENSIONS
beam_width = 0.6096;
beam_wall = 0.019;
beam_length = 30;
num_elem = 30;
element_length = beam_length/num_elem;
Heavy_Weight = 1e3;
density_rigid_link = density/10;

load SS_Damping_1e7.mat

extrusion_data_def = Extr_Data_Box(beam_width,beam_width-2*beam_wall,beam_width,beam_width-2*beam_wall);

% Uniform load per unit length = rho * area * g
q_def = density*(beam_width^2-(beam_width-2*beam_wall)^2)*9.81;

% Area moment of inertia
Ixx_def = (beam_width^4-(beam_width-2*beam_wall)^4)/12;

% Static deflection for uniformly loaded beam
staticDefl_def = q_def*beam_length^4/(8*youngsM*Ixx_def);

% Natural frequencies
A_fixedFree = [3.52 22.0 61.7 121.0];
wn_def = A_fixedFree*(youngsM*Ixx_def/(q_def/9.8*beam_length^4))^0.5/(2*pi);

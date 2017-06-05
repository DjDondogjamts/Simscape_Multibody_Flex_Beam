
function [kbendingx, kbendingy, kbendingz, kelongz, element_length] = Compute_GFE_Prop(rho, youngsM, shearM, numelem, beam_length, beam_width,beam_wall)
% Compute_GFE_Prop calculates stiffness for the generalized flexible 
% element in a hollow flexible beam.
% [kbendingx, kbendingy, kbendingz, kelongz, element_length] = 
% Compute_GFE_Prop(rho, youngsM, shearM, numelem, beam_length, beam_width,
% beam_wall)
% This function returns bending stiffness in all 3 direction (x,y,z) as
% well as elongation stiffness in z direction
% You need to specify
% rho - Density (kg/m^3)
% youngsM - Young's Modulus (N/m^2)
% shearM - Shear Modulus (N/m^2)
% numelem - Number of flexible elements in the body
% beam_length - Length of the entire flexible body (m)
% beam_width - Width, height of the body cross section area (m)
% beam_wall - Wall thickness (m)

% Copyright 2014 The MathWorks, Inc.

element_length = beam_length/numelem;

% CALCULATE CROSS AREA FOR A HOLLOW SQUARE
crossArea = (beam_width)^2-(beam_width-beam_wall*2)^2;

% BEAM ELEMENT AREA MOMENT OF INERTIA ALONG THE DIRECTION OF BENDING (m^4)
Ixx = beam_width*beam_width^3/12-(beam_width-2*beam_wall)^4/12;
Iyy = Ixx;
J = Ixx + Iyy;

% CANTILEVER BENDING STIFFNESS
kbendingx = youngsM * Ixx / element_length;
kbendingy = youngsM * Iyy / element_length;
kbendingz   = shearM * J/ element_length;
kelongz   = youngsM * crossArea/element_length;


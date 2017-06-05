
function [kbendingx, kbendingy, kbendingz, kelongz, element_length] = Compute_GFE_Prop(rho, youngsM, shearM, numelem, beam_length, beam_width,beam_wall)
% Copyright 2014-2016 The MathWorks, Inc.

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


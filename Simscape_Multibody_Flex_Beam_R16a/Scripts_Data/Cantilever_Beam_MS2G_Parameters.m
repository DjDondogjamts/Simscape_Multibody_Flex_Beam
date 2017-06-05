% MATERIAL PROPERTIES
% Copyright 2014-2016 The MathWorks, Inc.

density = 7850;                 % STEEL DENSITY
youngsM = 200E9;                % MODULUS OF ELASTICITY
shearM = 80E9;                  % SHEAR MODULUS
Damping = 1e7;                  % DAMPING COEFFICIENT -- HIGH FOR DEFLECTION TEST
gravity = [0 -9.80665 0];

% BEAM DIMENSIONS
beam_width = 0.6096;
beam_wall = 0.019;
beam_length = 30;
num_elem = 30;
element_length = beam_length/num_elem;
Heavy_Weight = 1e3;
density_rigid_link = density/10;


%{
flexBeamElement.material    = material;
flexBeamElement.density     = density;
flexBeamElement.crossArea   = crossArea;
flexBeamElement.length      = element_length;
flexBeamElement.cgLeng      = cgLeng;
flexBeamElement.beamDir     = beamDir;
flexBeamElement.Inertia     = Inertia;
flexBeamElement.youngsM     = youngsM;
flexBeamElement.shearM      = shearM;
flexBeamElement.Ixx         = Ixx;
flexBeamElement.Iyy         = Iyy;
flexBeamElement.matDamping  = matDamping;
% element_length = beam_length/num_elem;
% 
% % -- CALCULATED QUANTITIES --
% crossArea = (beam_width)^2-(beam_width-beam_wall*2)^2;
% cgLeng = element_length/2;
% 
% % BEAM ELEMENT AREA MOMENT OF INERTIA ALONG THE DIRECTION OF BENDING (m^4)
% Ixx = beam_width*beam_width^3/12-(beam_width-2*beam_wall)^4/12;
% Iyy = Ixx;
% J = Ixx + Iyy;
% 
% % CANTILEVER BENDING STIFFNESS
% bending_stiffness = youngsM * Ixx / element_length;
% 
% kbendingx = youngsM * Ixx / element_length;
% kbendingy = youngsM * Iyy / element_length;
% ktwistz   = shearM * J/ element_length;
% kelongz   = youngsM * crossArea/element_length;
% 
% 
% % -- FULL BEAM CALCULATIONS --
% % MASS MOMENT OF INERTIA ALONG THE DIRECTION OF BENDING (m^4)
% I_xf = density*(beam_width^2*element_length)*(beam_width^2+element_length^2)/12-density*((beam_width-2*beam_wall)^2*element_length)*((beam_width-beam_wall)^2+element_length^2)/12;
% I_yf = I_xf;
% 
% % MASS MOMENT OF INERTIA ABOUT BEAM AXIS
% I_zf = density*(beam_width^2*element_length)*(beam_width^2+beam_width^2)/12-density*((beam_width-2*beam_wall)^2*element_length)*((beam_width-beam_wall)^2+(beam_width-beam_wall)^2)/12;
% Inertiaf = [I_xf 0 0;0 I_yf 0;0 0 I_zf];
% 
% % -- HALF BEAM CALCULATIONS --
% % MASS MOMENT OF INERTIA ALONG THE DIRECTION OF BENDING (m^4)
% I_xh = density*(beam_width^2*(element_length/2))*(beam_width^2+(element_length/2)^2)/12-density*((beam_width-2*beam_wall)^2*(element_length/2))*((beam_width-beam_wall)^2+(element_length/2)^2)/12;
% I_yh = I_xh;
% 
% % MASS MOMENT OF INERTIA ABOUT BEAM AXIS
% I_zh = density*(beam_width^2*(element_length/2))*(beam_width^2+beam_width^2)/12-density*((beam_width-2*beam_wall)^2*(element_length/2))*((beam_width-beam_wall)^2+(beam_width-beam_wall)^2)/12;
% 
% Inertiah = [I_xh 0 0;0 I_yh 0;0 0 I_zh];

% Flexible Cantilever attached Bob or rigid link parameter
[flexBeamElement] = mech_flexible_beamelement(flexBeamElement);
%}

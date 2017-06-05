function [kbendingx, kbendingy, kbendingz, kelongz, element_length] =...
    Compute_GFE_Prop(youngsM, shearM, numelem, beam_length, xc_type, xc_params)
% Copyright 2014-2017 The MathWorks, Inc.

element_length = beam_length/numelem;
if(xc_type==1)
    x    = xc_params(1);
    x_in = xc_params(2);
    y    = xc_params(3);
    y_in = xc_params(4);
    [Ixx, Iyy, J, crossArea] = Area_Moment_Inertia_Rectangle(x,x_in,y,y_in);
elseif(xc_type==2)
    d    = xc_params(1);
    d_in = xc_params(2);
    [Ixx, Iyy, J, crossArea] = Area_Moment_Inertia_Circle(d,d_in);
elseif(xc_type==3)
    Ixx  = xc_params(1);
    Iyy  = xc_params(2);
    J    = xc_params(3);
    extrusion_data_vec = xc_params(4:end);
    extrusion_data = reshape(extrusion_data_vec,[length(extrusion_data_vec)/2,2]);
    crossArea = Area_From_Extr_Data(extrusion_data);
end

% Cantilever bending stiffness
kbendingx = youngsM * Ixx / element_length;
kbendingy = youngsM * Iyy / element_length;
kbendingz = shearM * J/ element_length;
kelongz   = youngsM * crossArea/element_length;
end

function [Ixx, Iyy, J, crossArea] = Area_Moment_Inertia_Rectangle(x,x_in,y,y_in)

crossArea = x*y-x_in*y_in;

% Beam element area moment of inertia along the direction of bending (m^4)
Ixx = x*y^3/12-x_in*y_in^3/12;
Iyy = y*x^3/12-y_in*x_in^3/12;
J = Ixx + Iyy;
end

function [Ixx, Iyy, J, crossArea] = Area_Moment_Inertia_Circle(d,d_in)

crossArea = pi/4*(d^2-d_in^2);

% Beam element area moment of inertia along the direction of bending (m^4)
Ixx = pi/64*(d^4-d_in^4);
Iyy = Ixx;
J = Ixx + Iyy;
end



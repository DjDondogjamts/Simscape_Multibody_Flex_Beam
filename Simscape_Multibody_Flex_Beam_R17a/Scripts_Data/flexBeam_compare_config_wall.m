function flexBeam_compare_config_wall(mdlname,type)
% Copyright 2014-2017 The MathWorks, Inc.

if(strcmpi(type,'cantilever'))
    set_param([mdlname '/Wall LP'],'OverrideUsingVariant','Fixed');
    set_param([mdlname '/Wall SS'],'OverrideUsingVariant','Fixed');
    
    LTIpth = find_system(mdlname,'ReferenceBlock','cstblocks/LTI System');
    set_param(char(LTIpth),'sys','linsys_beam_fixfree');
    
elseif(strcmpi(type,'pendulum'))
    set_param([mdlname '/Wall LP'],'OverrideUsingVariant','Rotate');
    set_param([mdlname '/Wall SS'],'OverrideUsingVariant','Rotate');
    
    LTIpth = find_system(mdlname,'ReferenceBlock','cstblocks/LTI System');
    set_param(char(LTIpth),'sys','linsys_beam_rotfree');
end
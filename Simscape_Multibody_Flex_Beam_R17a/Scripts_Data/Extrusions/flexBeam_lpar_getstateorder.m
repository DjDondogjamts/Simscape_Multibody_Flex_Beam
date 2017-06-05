function state_order = flexBeam_lpar_getstateorder(b_h)
% Copyright 2014-2017 The MathWorks, Inc.
u=find_system(b_h,'LookUnderMasks','on','Name','Flex Joint');

for i=1:length(u)
    if(regexp(u{i},'/Flex_Elem_\d/'))
        u{i}=strrep(u{i},'Flex_Elem_','Flex_Elem_0');
    end
end

v=sort(u);

for i=1:length(v)
    x{i}=strrep(v{i},'Flex_Elem_0','Flex_Elem_');
end

state_order = x;



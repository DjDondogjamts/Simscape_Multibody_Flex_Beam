% Determine static deflection of cantilever beam using transient simulation
% Copyright 2014-2017 The MathWorks, Inc.

% Configure model
mdl = bdroot;

% Configure model
% Fix connection to wall
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');
load_system('FlexBeamElements_Lib');

% Configure flexibility
temp_ftype = get_param([mdl '/Flex_Body'],'radio_flextype');
set_param([mdl '/Flex_Body'],'radio_flextype','3-Axis Bending, Elongation')

% Run simulation and get tip deflection
sim(mdl);                
disp(['Static Deflection is ' num2str(TipDef.signals(2).values(end)) ' m']);

% Reset flexibility to original value
set_param([mdl '/Flex_Body'],'radio_flextype',temp_ftype)

% Copyright 2014-2017 The MathWorks, Inc.

Flexible_Beam_HomeDir = pwd;

addpath(Flexible_Beam_HomeDir);
addpath([Flexible_Beam_HomeDir filesep 'Models']);
addpath([Flexible_Beam_HomeDir filesep 'Scripts_Data']);
addpath([Flexible_Beam_HomeDir filesep 'Scripts_Data' filesep 'Extrusions']);
addpath([Flexible_Beam_HomeDir filesep 'Libraries']);
addpath([Flexible_Beam_HomeDir filesep 'Images']);
addpath([Flexible_Beam_HomeDir filesep 'html' filesep 'html']);

flexBeam_default_parameters;

Flexible_Beam_Compare;
open('Flexible_Beam_Demo_Script.html');

    
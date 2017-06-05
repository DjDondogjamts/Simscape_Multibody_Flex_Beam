% Copyright 2014 The MathWorks, Inc.

Flexible_Beam_HomeDir = pwd;

addpath(pwd);
addpath([pwd '\Models']);
addpath([pwd '\Scripts_Data']);
addpath([pwd '\Library']);
addpath([pwd '\Images']);
Cantilever_Beam_MS2G_Parameters;
Flexible_Beam_Compare;
open('Flexible_Beam_Demo_Script.html');
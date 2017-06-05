% Compare simulation time for full and balred reduced state space models
% for cantilever beam with one fixed end and a load on the other end

% Copyright 2014-2017 The MathWorks, Inc.

% Load state-space models with damping 1e5 N/(m/s)
load SS_Damping_1e5_fixfree.mat

% Open the model to perform comparison
modelname = 'Flexible_Beam_SS_Full_Reduced';
open_system(modelname);
Rigid_Body  = 1;
Heavy_Weight = 1e3;

ltipth = find_system(modelname,'RegExp','on','ReferenceBlock','LTI');

% Simulate using full state-space model
set_param(char(ltipth),'sys','linsys_beam_fixfree');
sim(modelname)
Elapsed_Sim_Time_full = Elapsed_Sim_Time;
Deflection_DATA_full = Deflection_DATA;

% Simulate using reduced state-space model
set_param(char(ltipth),'sys','linsys_beam_fixfree_reduced');

sim(modelname)
Elapsed_Sim_Time_red = Elapsed_Sim_Time;
Deflection_DATA_red = Deflection_DATA;

% Plot simulation results
% Reuse figure if it exists, else create new figure
if ~exist('h1_Flexible_Beam_SS_Full_Reduced', 'var') || ...
        ~isgraphics(h1_Flexible_Beam_SS_Full_Reduced, 'figure')
    h1_Flexible_Beam_SS_Full_Reduced = figure('Name', 'Flexible_Beam_SS_Full_Reduced');
end
figure(h1_Flexible_Beam_SS_Full_Reduced)
clf(h1_Flexible_Beam_SS_Full_Reduced)

plot(Deflection_DATA_full.time,Deflection_DATA_full.signals(1,2).values,'LineWidth',1)
hold on
plot(Deflection_DATA_red.time,Deflection_DATA_red.signals(1,2).values,'LineWidth',1)
hold off
ylabel('Vertical Deflection (m)')
xlabel('Time (s)')

temp_loadcfg = get_param([modelname '/Weight'],'ActiveVariant');

switch temp_loadcfg
    case 'Link', textstr = 'Load: Link';
    case 'Bob', textstr = 'Load: Bob';
end

title('Comparison Between Full & Reduced State-Space Model')
legend({...
    ['Full SS: Sim time = ' sprintf('%0.2f',Elapsed_Sim_Time_full) ' sec'],...
    ['Reduced: Sim time = ' sprintf('%0.2f',Elapsed_Sim_Time_red) ' sec']},...
    'Location','Best');
text(0.7,0.05,textstr,'Units','normalized')

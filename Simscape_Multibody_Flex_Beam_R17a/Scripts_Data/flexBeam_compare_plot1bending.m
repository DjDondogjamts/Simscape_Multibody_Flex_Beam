% Code to plot simulation results from Flexible_Beam_Compare
%% Plot Description:
%
% The plot below shows the comparison between the tip deflection of a beam
% modeled using lumped parameter and state-space methods.
%
% Copyright 2017 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_Flexible_Beam_Compare', 'var')
    sim('Flexible_Beam_Compare')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_Flexible_Beam_Compare', 'var') || ...
        ~isgraphics(h1_Flexible_Beam_Compare, 'figure')
    h1_Flexible_Beam_Compare = figure('Name', 'Flexible_Beam_Compare');
end
figure(h1_Flexible_Beam_Compare)
clf(h1_Flexible_Beam_Compare)

% Get simulation results
temp_tipDeflection = logsout_Flexible_Beam_Compare.get('beam_tip_xyz');

% Plot results
%simlog_handles(1) = subplot(2, 1, 1);
plot(temp_tipDeflection.Values.Time,...
    temp_tipDeflection.Values.Data(:,[2,1]), 'LineWidth', 1)
hold on
plot(temp_tipDeflection.Values.Time,...
    temp_tipDeflection.Values.Data(:,1)-temp_tipDeflection.Values.Data(:,2), 'LineWidth', 1)
hold off
grid on
ylabel('Deflection (m)')

if(simlog_Flexible_Beam_Compare.hasChild('Wall_LP'))
    temp_wallcfg = 'Pendulum';
else
    temp_wallcfg = 'Cantilever';
end
if(simlog_Flexible_Beam_Compare.hasChild('Weight_LP'))
    temp_loadcfg = 'Link';
else
    temp_loadcfg = 'Ball';
end

title(['Beam Bending (' temp_wallcfg ', ' temp_loadcfg ')']);
xlabel('Time (s)')

legend({'State-Space','Lumped Parameter','Difference'},'Location','SouthEast');

% Remove temporary variables
clear temp_tipDeflection
clear temp_wallcfg temp_loadcfg


% Code to plot simulation results from Flexible_Beam_LP_Modes
%% Plot Description:
%
% The plot below shows the comparison between the tip deflection of a beam
% modeled using lumped parameter as the number of elements varies 
%
% Copyright 2017 The MathWorks, Inc.

mdl = bdroot;
temp_vectornumelem = [5:5:30];
temp_numelem = num_elem;
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');

for temp_i = 1:length(temp_vectornumelem)
    num_elem = temp_vectornumelem(temp_i);
    sim(mdl)
    %temp_tipDeflection = logsout_Flexible_Beam_LP_Modes.get('beam_tip_xyz');
    temp_sdef(temp_i) = TipDef.signals(2).values(end);
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_Flexible_Beam_LP', 'var') || ...
        ~isgraphics(h1_Flexible_Beam_LP, 'figure')
    h1_Flexible_Beam_LP = figure('Name', 'Flexible_Beam_LP_Modes');
end
figure(h1_Flexible_Beam_LP)
clf(h1_Flexible_Beam_LP)

% Plot results
%simlog_handles(1) = subplot(2, 1, 1);
plot(temp_vectornumelem,temp_sdef,'Marker','o')
hold on
plot([0 max(temp_vectornumelem)],[-1 -1]*staticDefl_def ,'k--','LineWidth', 1)
hold off
grid on
ylabel('Deflection (m)');
set(gca,'YLim',[-round(1.1*staticDefl_def,1) 0]);

title('Static Deflection from Lumped Parameter Model');
xlabel('Number of Elements')

legend({'Simulation','Theory'},'Location','Best');

% Remove temporary variables
clear simlog_handles
clear temp_i temp_numelem temp_sdef temp_vectornumelem


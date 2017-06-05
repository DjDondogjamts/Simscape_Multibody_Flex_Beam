% COMPARE TIME TO SIMULATE LINEAR FULL & BALRED REDUCED SS MODELS FOR 
% CANTILEVER BEAM RIGIDLY ATTACHED TO WALL ON ONE END AND A HEAVY WEIGHT
% ATTTACHED ON ITS OTHER END.

% Copyright 2014 The MathWorks, Inc.

% LOADING PRESAVED SS MODELS WITH DAMPING 1E5 N/(M/S)
load SS_Damping_1e5_fixfree.mat

% OPEN THE MODEL FOR COMPARISON
mdln = 'Compare_Flexible_Cantilever_SS_Full_Reduced';
open_system(mdln);
Rigid_Body  = 1;
Heavy_Weight = 1e3;

ltipth = find_system(bdroot,'RegExp','on','ReferenceBlock','LTI');

% SIMULATE CANTILEVER BEAM FULL SS MODEL 
set_param(char(ltipth),'sys','linsys_beam_fixfree');
sim(mdln)
disp(['Elapsed Time (Full State-Space) = ' num2str(Elapsed_Sim_Time)])
Deflection_DATA_full = Deflection_DATA;

% SIMUALATE CANTILEVER BEAM REDUCED SS MODEL
set_param(char(ltipth),'sys','linsys_beam_fixfree_reduced');
sim(mdln)
disp(['Elapsed Time (Reduced State-Space) = ' num2str(Elapsed_Sim_Time)])
Deflection_DATA_red = Deflection_DATA;

%PLOT SIMULATION RESULTS
figure(1)
plot(Deflection_DATA_full.time,Deflection_DATA_full.signals(1,2).values,'r','LineWidth',2)
hold on
plot(Deflection_DATA_red.time,Deflection_DATA_red.signals(1,2).values,'b:','LineWidth',2)
hold off
xlabel('Time (s)','FontSize',12)
title('Comparison Between Full & Reduced State-Space Model')
legend('Full','Reduced')

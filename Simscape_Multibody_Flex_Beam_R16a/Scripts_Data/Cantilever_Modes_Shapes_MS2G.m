% CALCULATE NATURAL FREQUENCIES AND MODE SHAPES FOR CANTILEVER BEAM 
% RIGIDLY ATTACHED TO WALL ON ONE END, WITH OTHER END BEING FREE
% Copyright 2014-2016 The MathWorks, Inc.

% SAVE CURRENT DAMPING VALUE
Damping_temp = Damping;

% ENSURE DAMPING IS ZERO FOR MODE CALCULATION
Damping = 0;

% FLEXIBLE ELEMENT LENGTH
element_length = beam_length/num_elem;

% SETUP THE MODEL FOR LINEARIZATION
mdl = bdroot;
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');
load_system('FlexBeamElement_MS2G_Lib')
set_param('FlexBeamElement_MS2G_Lib', 'Lock', 'off');
set_param('FlexBeamElement_MS2G_Lib/Flex_Element','BlockChoice','Bend')
set_param(mdl,'SimulationCommand','update')
sys_io = getlinio(mdl);             % FIND INPUTS AND OUTPUTS

% LINEARIZE THE MODEL
linsys1 = linearize(mdl,sys_io,'StateOrder',State_order);    % OBTAIN LINEAR MODEL

% FIND STATES OF INTEREST
w_state_inds = find(~cellfun(@isempty,strfind(linsys1.StateName,'.Rz.w')));
q_state_inds = find(~cellfun(@isempty,strfind(linsys1.StateName,'.Rz.q')));

% GET EIGENVALUES
lambda1 = eig(linsys1.a);           % GET EIGENVALUES (complex)
natural_freq = unique(abs(lambda1(w_state_inds))/(2*pi)); % FREQ HZ
disp('Modes (Hz):');
sprintf('Modes (Hz):\n  %0.3f\n  %0.3f\n  %0.3f\n  %0.3f\n  %0.3f ',natural_freq(1:5))

% GET EIGENVECTORS
[V, D] = eigs(linsys1(end,end).a,8,'sm');
colordef black
% CONSTRUCT AND PLOT MODE SHAPES
for mode_num = 1:4
    % FIND JOINT ANGLE VALUES WITHIN EACH EIGENVECTOR
    if abs(abs(imag(V(q_state_inds(1),2*mode_num))/abs(V(q_state_inds(1),2*mode_num)))-1)<1e-3
        joint_ang = imag(V(q_state_inds,2*mode_num)); 
    else
        joint_ang = real(V(q_state_inds,2*mode_num)); 
    end
    % ANGLE OF CURRENT ELEMENT WITH RESPECT TO HORIZONTAL
    % IS SUM OF ALL ANGLES BETWEEN ELEMENT AND WALL
    theta = cumsum(joint_ang);     
    
    % Y-DISPLACEMENT OF ELEMENT = Y-DISP OF PREVIOUS ELEMENT + l*sin(theta)
    y_mode = zeros(size(q_state_inds));
    for i = 2:length(q_state_inds)
        y_mode(i) = y_mode(i-1) + element_length*sin(theta(i-1));
    end
    subplot(2,2,mode_num)
    plot(y_mode,'LineWidth',2)
    title(['Mode ' num2str(mode_num) ' = ' num2str(natural_freq(mode_num)) '(Hz)'],'FontSize',13);
end
colordef white

% SAVE CURRENT DAMPING VALUE
Damping = Damping_temp; clear Damping_temp theta y_mode joint_ang

% CLOSE THE LIBRARY MODEL
close_system('FlexBeamElement_MS2G_Lib',0)

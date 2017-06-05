% Calculate natural frequencies and mode shapes for cantilever beam
% with one fixed end and one free end

% Copyright 2014-2017 The MathWorks, Inc.

% Save current damping value
Damping_temp = Damping;

% Ensure damping is zero for mode calculation
Damping = 0;

% Determine flexible element length
element_length = beam_length/num_elem;

% Configure model for linearization
mdl = bdroot;
set_param([mdl '/Wall Conn'],'OverrideUsingVariant','Fixed');

% Save current flexibility type
temp_ftype = get_param([mdl '/Flex_Body'],'radio_flextype');
set_param([mdl '/Flex_Body'],'radio_flextype','1-Axis Bending')

% Find inputs and outputs for linearization
set_param(mdl,'SimulationCommand','update')
sys_io = getlinio(mdl);             

% Linearize the model
linsys1 = linearize(mdl,sys_io,'StateOrder',state_order);    

% Find states of interest
w_state_inds = find(~cellfun(@isempty,strfind(linsys1.StateName,'.Rz.w')));
q_state_inds = find(~cellfun(@isempty,strfind(linsys1.StateName,'.Rz.q')));

% Get eigenvalues
lambda1 = eig(linsys1.a);           % Get eigenvalues (complex)
natural_freq = unique(abs(lambda1(w_state_inds))/(2*pi)); % Freq in Hz
%disp('Modes (Hz):');
sprintf('Modes (Hz):\n  %0.3f\n  %0.3f\n  %0.3f\n  %0.3f\n  %0.3f ',natural_freq(1:5));

% Get eigenvectors
[V, D] = eigs(linsys1(end,end).a,8,'sm');

%% Reuse figure if it exists, else create new figure
if ~exist('h1_Flexible_Beam_LP', 'var') || ...
        ~isgraphics(h1_Flexible_Beam_LP, 'figure')
    h1_Flexible_Beam_LP = figure('Name', 'h1_Flexible_Beam_LP');
end
figure(h1_Flexible_Beam_LP)
clf(h1_Flexible_Beam_LP)

% Construct and plot mode shapes
for mode_num = 1:4
    % Find joint angle values within each eigenvector
    if abs(abs(imag(V(q_state_inds(1),2*mode_num))/abs(V(q_state_inds(1),2*mode_num)))-1)<1e-3
        joint_ang = imag(V(q_state_inds,2*mode_num)); 
    else
        joint_ang = real(V(q_state_inds,2*mode_num)); 
    end
    % Angle of current element with respect to horizontal
    % is sum of all angles between element and wall
    theta = cumsum(joint_ang);     
    
    % y-displacement of element = y-disp.of previous element + 1*sin(theta)
    y_mode = zeros(size(q_state_inds));
    for i = 2:length(q_state_inds)
        y_mode(i) = y_mode(i-1) + element_length*sin(theta(i-1));
    end
    subplot(2,2,mode_num)
    plot(y_mode,'LineWidth',2)
    title(['Mode Shape ' num2str(mode_num)]);
    text(0.05,0.1,['\bf\omega_{n}\rm = ' num2str(natural_freq(mode_num)) ' Hz'],...
        'Units','Normalized');
end

%% Reset damping value and flexibility type
Damping = Damping_temp; 
set_param([mdl '/Flex_Body'],'radio_flextype',temp_ftype)

clear Damping_temp theta y_mode joint_ang


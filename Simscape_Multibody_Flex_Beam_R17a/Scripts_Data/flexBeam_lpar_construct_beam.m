function flexBeam_lpar_construct_beam(b_h,numelem,flextype,lin)
% Support function for Flex_Body element.
% Automatically constructs chain of mass-spring-dampers based on arguments
% in mask of Flex_Body subsystem.

% Copyright 2014-2017 The MathWorks, Inc.

% Save handle to flex beam block
thisblock = b_h;

% Set annotation
anno = ['No of Elem: ' num2str(numelem)];
set_param(thisblock, 'AttributesFormatString',anno);

% Load model where elements are saved
srcLib = 'FlexBeamElements_Lib';
load_system(srcLib);

if numelem <1
    error('Number of Flexible elements should be greater than 0')
end

% Check for existing blocks for linearizable beam
in_h = find_system(thisblock,'LookUnderMasks','all','SearchDepth',1,'BlockType','Inport');
out_h = find_system(thisblock,'LookUnderMasks','all','SearchDepth',1,'BlockType','Outport');
mxc_h = find_system(thisblock,'LookUnderMasks','all','SearchDepth',1,'BlockType','Concatenate');

% Check for change in linearization configuration
rebuild_flag = 0; % Assume no change
if(lin==1)
    if(isempty(in_h))
        rebuild_flag = 1;
        add_block('built-in/Inport',[thisblock '/Flin'],'Position',[105 78 135 92]);
        add_block('built-in/Outport',[thisblock '/wz'],...
            'Position',[105   423   135   437],...
            'Orientation','left');
        add_block(sprintf('simulink/Math Operations/Matrix\nConcatenate'),[thisblock '/Matrix Concatenate'],...
            'Position',[200   338   255   517],...
            'Orientation','left',...
            'ConcatenateDimension','1');
    end
else
    if(~isempty(in_h))
        rebuild_flag = 1;
        delete_block([thisblock '/Flin']);
        delete_block([thisblock '/wz']);
        delete_block([thisblock '/Matrix Concatenate']);
    end
end

% If existing chain of elements has a different length than request,
% or if the linearization configuration has changed, rebuild chain.
prev_flex_bod = find_system(thisblock,'LookUnderMasks','all','RegExp','on','Name','Flex_Elem_*');
if ((~isempty(prev_flex_bod) && length(prev_flex_bod) ~= numelem) || ...
        rebuild_flag==1)
    delete_block(prev_flex_bod(1:end))
    
    % If beam should be linearizable
    if(lin==1)
        set_param([thisblock '/Matrix Concatenate'],'NumInputs','numelem')
        flex_elem_src = [srcLib '/Flex_Elem_lin'];
    else
        flex_elem_src = [srcLib '/Flex_Element'];
    end
    
    % Delete lines
    linehan = find_system(thisblock,'LookUnderMasks','all','FindAll','on','type','line');
    if ~isempty(linehan)
        delete_line(linehan)
    end
    
    % Create Multibody Connection Port
    blk_or = [105 155 140 195];    
    set_param([thisblock '/B'],'Position',blk_or)
    
    % Create and connect first rigid transform
    set_param([thisblock '/' sprintf('Transform\nBeamX')],'Position',blk_or+[80 0 80 0])
    add_line(thisblock,['B/Rconn1'],[sprintf('Transform\nBeamX') '/Lconn1'],'autorouting','on');
    
    % Add and connect first flexible element
    % Flexible element saved in separate model file
    be_h=add_block(flex_elem_src,[thisblock '/Flex_Elem_' num2str(1)],'Position',blk_or+[80 0 80 0]*2);
    add_line(thisblock,[sprintf('Transform\nBeamX') '/Rconn1'],['Flex_Elem_' num2str(1) '/Lconn1'],'autorouting','on');
    if(lin==1)
        add_line(thisblock,'Flin/1',['Flex_Elem_' num2str(1) '/1'],'autorouting','on')
        add_line(thisblock,['Flex_Elem_' num2str(1) '/1'],'Matrix Concatenate/1','autorouting','on')
        set_param([thisblock '/Flex_Elem_' num2str(1)],'signal_ind','[1 2 3]')
    end
    
    % Add and connect remainder of flexible elements
    for i = 2:1:numelem
        add_block(flex_elem_src,[thisblock '/Flex_Elem_' num2str(i)],'Position',blk_or+(i+1)*[80 0 80 0])
        add_line(thisblock,['Flex_Elem_' num2str(i-1) '/Rconn1'],['Flex_Elem_' num2str(i) '/Lconn1'],'autorouting','on');
        if(lin==1)
            add_line(thisblock,'Flin/1',['Flex_Elem_' num2str(i) '/1'],'autorouting','on')
            add_line(thisblock,['Flex_Elem_' num2str(i) '/1'],['Matrix Concatenate/' num2str(i)],'autorouting','on')
            set_param([thisblock '/Flex_Elem_' num2str(i)],'signal_ind',['[' num2str([3*i-2 3*i-1 3*i]) ']'])
        end
    end
    set_param([thisblock '/F'],'Position',blk_or+ (numelem+2)*[80 0 80 0]);
    add_line(thisblock,['Flex_Elem_' num2str(numelem) '/Rconn1'],['F/Rconn1'],'autorouting','on');
    if(lin==1)
        add_line(thisblock,'Matrix Concatenate/1','wz/1','autorouting','on')
    end
end

flexBeam_lpar_configure_flextype(thisblock,flextype,srcLib)

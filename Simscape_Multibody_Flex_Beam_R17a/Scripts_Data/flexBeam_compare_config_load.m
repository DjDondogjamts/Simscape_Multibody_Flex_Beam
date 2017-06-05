function flexBeam_compare_config_load(modelname,type)
% Copyright 2014-2017 The MathWorks, Inc.
blk_list = find_system(modelname,'SearchDepth',1,'regexp','on','Name','Weight.*');
if ~isempty(blk_list)
    for i=1:length(blk_list)
        set_param(blk_list{i},'OverrideUsingVariant',type);
    end
end

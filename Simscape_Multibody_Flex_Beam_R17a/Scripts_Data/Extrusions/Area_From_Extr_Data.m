function area = Area_From_Extr_Data(xy_data)
%Area_From_Extr_Data Calculate area based on coordates.
%   area = Area_From_Extr_Data(xy_data)
%   This function returns the area for a polygon described by 2D
%   coordinates. This method will produce the wrong answer for
%   self-intersecting polygons (one side crosses over another). It will
%   work correctly for triangles, regular and irregular polygons, convex or
%   concave polygons.

% Copyright 2017 The MathWorks, Inc.

runningSum = 0;
for i=1:(size(xy_data,1)-1)
    runningSum = runningSum + ...
        xy_data(i,1)  *xy_data(i+1,2)-...
        xy_data(i+1,1)*xy_data(i,2);
end

runningSum = runningSum + ...
        xy_data(end,1)*xy_data(1,2)-...
        xy_data(1,1)  *xy_data(end,2);
    
    area = runningSum/2;
    
    
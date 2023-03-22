function [aRatio, start_width, start_height, width, height] = computeAspectRatio(image)
    [num_rows, num_cols] = size(image);

    % Fill your code
	%function usage :computeSide with input 0=> computes the width dimension
    [start_width, width] = computeSide(image, 0);
    
    %function usage :computeSide with input 1=> computes the height dimension
    [start_height, height] = computeSide(image, 1);
    
    aRatio = width/height;

end


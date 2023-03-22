%Function that is used for computing the  length of NON-black pixels in an image
function [start , diff] = computeSide(image, side)

    %if side == 1 then return the height side of the image
    %For execution: To do that we flip the image and run the above algorithm
    if side == 1
        image = image';
    end
    
    [num_rows, num_cols] = size(image);
    start  = num_cols;
    the_end = 1;
    
    %Finding the starting column of the wanted side
    for  i = 1 : num_rows
        for j = 1 : num_cols
            if(image(i,j)~=0)
                start = min([start j]);
                break;
            end
        end 
    end
    
    %Finding the ending column of the wanted side
    for i = 1 : num_rows
        for j = num_cols: -1 : 1 
            if(image(i,j)~=0)
                 the_end = max([the_end j]);
                break;
            end 
        end
    end
    
    %Width/Height
    start = start -0.5;
    the_end = the_end  + 0.5;
    diff = the_end - start;
	
end

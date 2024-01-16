function [decodedbits] = findminimumpath3(col,compare_path,iterations)

% Finding the minimum value in compare_path to decide the 
% first state in the path back.

[r,c] = find(compare_path == min(compare_path,[],'all'));
state = [1 3 5 7; 1 3 5 7;1 3 5 7;1 3 5 7;2 4 6 8; 2 4 6 8; 2 4 6 8; 2 4 6 8];
state = state(r(1),c(1));

% Tracing back, to find the minimum path.1

    for t = iterations:-1:2    

        column = col(state,t); 
        if state == 1 && column == 1
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 1;
        elseif state == 1 && column == 2
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 3;
        elseif state == 1 && column == 3
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 5;
        elseif state == 1 && column == 4 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 7;
        elseif state == 2 && column == 1
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 1;
        elseif state == 2 && column == 2 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 3;
        elseif state == 2 && column == 3
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 5;
        elseif state == 2 && column == 4 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 7;
        elseif state == 3 && column == 1
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 1;
        elseif state == 3 && column == 2 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 3;
        elseif state == 3 && column == 3
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 5;
        elseif state == 3 && column == 4 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 7;        
        elseif state == 4 && column == 1
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 1;
        elseif state == 4 && column == 2 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 3;
        elseif state == 4 && column == 3
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 5;
        elseif state == 4 && column == 4 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 7;
        elseif state == 5 && column == 1
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 2;
        elseif state == 5 && column == 2 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 4;
        elseif state == 5 && column == 3
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 6;
        elseif state == 5 && column == 4 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 8;
        elseif state == 6 && column == 1
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 2;
        elseif state == 6 && column == 2
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 4;
        elseif state == 6 && column == 3 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 6;
        elseif state == 6 && column == 4 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 8;        
        elseif state == 7 && column == 1
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 2;
        elseif state == 7 && column == 2 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 4;
        elseif state == 7 && column == 3
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 6;
        elseif state == 7 && column == 4 
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 8;
        elseif state == 8 && column == 1
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 1;
                next_state = 2;
        elseif state == 8 && column == 2 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 1;
                next_state = 4;
        elseif state == 8 && column == 3
                decodedbits(2*t-1) = 1;
                decodedbits(2*t) = 0;
                next_state = 6;
        elseif state == 8 && column == 4 
                decodedbits(2*t-1) = 0;
                decodedbits(2*t) = 0;
                next_state = 8;
        end
        
        state = next_state;
    end
         
end 




function [decodedbits] = findminimumpath1(col,compare_path,iterations)

% Finding the minimum value in compare_path to decide the 
% first state in the path back.

[r,c] = find(compare_path == min(compare_path,[],'all'));
state = [1 2; 3 4 ;5 6;7 8];
state = state(r(1),c(1));

% Tracing back, to find the minimum path.1

    for t = iterations:-1:1    

        column = col(state,t); 
        if state == 1 & column == 1
                decodedbits(t) = 0;
                next_state = 1;
        elseif state == 1 & column == 2
                decodedbits(t) = 0;
                next_state = 2;
        elseif state == 2 & column == 1
                decodedbits(t) = 0;
                next_state = 3;
        elseif state == 2 & column == 2 
                decodedbits(t) = 0;
                next_state = 4;
        elseif state == 3 & column == 1
                decodedbits(t) = 1;
                next_state = 1;
        elseif state == 3 & column == 2 
                decodedbits(t) = 1;
                next_state = 2;
        elseif state == 4 & column == 1
                decodedbits(t) = 1;
                next_state = 3;
        elseif state == 4 & column == 2 
                decodedbits(t) = 1;
                next_state = 4;
        end
        state = next_state;
    end
        
end 
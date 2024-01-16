function [ decodedbit ] = Hardviterbi(y,x,enc)

% Initialization of vectors and iterations 

iterations = length(y)/2;
y = reshape(y,length(x(1,:)),[])';

col = zeros(length(x(:,1))/2,iterations)+inf;
path = zeros(length(x(:,1))/2,iterations);

% Initialization of the branch and the path metrics depeding on encoder 1,2 or 3
% path = branch metrics1
% compare_path = path metrics

if enc == 1                                            % For encoder 1
    col = zeros(4,iterations)+inf;
    path = zeros(4,iterations);
    path = [0 ;inf ;inf ;inf];                         
    compare_path = [0 inf; inf inf;0 inf;inf inf];     
elseif enc == 2 || enc == 3                            % For encoder 2 or 3
    col = zeros(16,iterations)+inf;
    path = zeros(16,iterations);
    path = [0;inf;inf;inf;inf;inf;inf;inf ;inf;inf;inf;inf;inf;inf;inf;inf ];
    compare_path = [0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf; 0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf];
end


% add, compare, and select the path with smallest distance (hamming distance) and save the
% the index of the path with the smallest distance

for t=1:iterations
    hamming_dist = sum(bitxor(repmat(y(t,:),length(x(:,1)),1),x),2);   % calculate hamming distance
    hamming_dist_mat = reshape(hamming_dist,2,[])';                    % reshape the matrix to be compared for different paths 
    compare_path = compare_path+hamming_dist_mat;                      % Add the hamming distance to the path
    [path,col(:,t)] = min(compare_path,[],length(x(1,:)));             % retrive the minimum path and column for the minimum path
    compare_path = reshape([path' path'],length(x(1,:)),[])';          % Reshape the matrix for the next step in the trellis
end

% Functions to find the minimum path depending on encoder 1,2,3 and 4.

if enc == 1
    decodedbit = findminimumpath1(col,compare_path,iterations);
elseif enc == 2 || enc == 3 
    decodedbit = findminimumpath2(col,compare_path,iterations);
elseif enc == 4
    decodedbit = findminimumpath3(col,compare_path,iterations);
else
     error('The requested encoder is not implemented, please input a different number')
end


end




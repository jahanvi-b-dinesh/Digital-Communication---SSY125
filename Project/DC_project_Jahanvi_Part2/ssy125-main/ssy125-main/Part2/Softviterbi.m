function [ decodedbit ] = Softviterbi(bits,x,enc,mod)

% Initialization of vectors and iterations 

iterations = length(bits);
bits = bits.';

% Mapper for Softviterbi alternatives1

x = mapper(x,mod);


% Initialization of the branch and the path metrics depeding on encoder 1,2 or 3

if enc == 1                             % Encoder 1
    col = zeros(4,iterations)+inf;
    path = zeros(4,iterations);
    path = [0 ;inf ;inf ;inf];
    compare_path = [0 inf; inf inf;0 inf;inf inf];
elseif (enc == 2 || enc == 3) && mod == 2           % Encoder 2 and 3 with QPSK
    col = zeros(16,iterations)+inf;
    path = zeros(16,iterations);
    path = [0;inf;inf;inf;inf;inf;inf;inf ;inf;inf;inf;inf;inf;inf;inf;inf ];
    compare_path = [0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf; 0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf];
elseif enc == 3 && mod == 1           % Encoder 2 and 3 with BPSK
    iterations = iterations/2;
    col = zeros(16,iterations)+inf;
    path = zeros(16,iterations);
    x = reshape(x,2,[]);
    bits = reshape(bits,2,[]).';
    path = [0;inf;inf;inf;inf;inf;inf;inf ;inf;inf;inf;inf;inf;inf;inf;inf ];
    compare_path = [0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf; 0 inf; inf inf;Inf inf;Inf inf; inf inf; inf inf;Inf inf;inf inf];
elseif enc == 4                         % Encoder 4
    col = zeros(8,iterations)+inf;
    path = zeros(8,iterations);
    path = [0 ;inf ;inf ;inf;inf ;inf ;inf;inf];
    compare_path = [0 inf inf inf; 0 inf inf inf;0 inf inf inf;0 inf inf inf;inf inf inf inf; inf inf inf inf;inf inf inf inf;inf inf inf inf];
else
    error('The requested encoder is not implemented, please input a different number under "enc" ')
end



% --------------------------------------------------------------------------
% The following test describes the for loop and how the soft viterbi works
% --------------------------------------------------------------------------
% euclidean_dist =  calculate the euclidean distance.
% euclidean_dist_mat = reshape the matrix to be compared for different paths
% compare_path = Add the euclidean distance to the path
% [path,col(:,t)] = retrive the minimum path and column for the minimum path
% compare_path =  Reshape the matrix for the next step in the trellis
% --------------------------------------------------------------------------


% add, compare, and select the path with smallest distance and save the
% the index of the path with the smallest distance

if (enc == 1 || enc == 2 || enc == 3) && mod == 2  % Encoder 1, 2, and 3 with QPSK
    for t=1:iterations
        euclidean_dist = abs( repmat(bits(t,:),length(x(1,:)),1) - x.').^2;
        euclidean_dist_mat = reshape(euclidean_dist,2,[])';
        compare_path = compare_path+euclidean_dist_mat;
        [path,col(:,t)] = min(compare_path,[],2);
        compare_path = reshape([path' path'],2,[])';
    end
elseif enc == 3 && mod == 1         % Encoder 3 with BSPK
    for t=1:iterations
        euclidean_dist = sum(abs( repmat(bits(t,:),length(x(1,:)),1) - x.'),2).^2;
        euclidean_dist_mat = reshape(euclidean_dist,2,[])';
        compare_path = compare_path+euclidean_dist_mat;
        [path,col(:,t)] = min(compare_path,[],2);
        compare_path = reshape([path' path'],2,[])';
    end 
elseif enc == 4                     % Encoder 4
     for t=1:iterations
        euclidean_dist = abs( repmat(bits(t,:),length(x(1,:)),1) - x.').^2;
        euclidean_dist_mat = reshape(euclidean_dist,8,[]);
        compare_path = compare_path+euclidean_dist_mat;
        [path,col(:,t)] = min(compare_path,[],2);
        path =  repmat(path,1,4);
        compare_path = reshape([path(1,:) path(2,:) path(3,:) path(4,:) path(5,:) path(6,:) path(7,:) path(8,:)],8,[]);
     end
else
     error('The requested encoder is not implemented, please input a different number "enc" ')
end

% Functions to find the minimum path depending on encoder 1,2,3 and 4.

if enc == 1
    decodedbit = findminimumpath1(col,compare_path,iterations);
elseif enc == 2 || enc == 3 
    decodedbit = findminimumpath2(col,compare_path,iterations);
elseif enc == 4
    decodedbit = findminimumpath3(col,compare_path,iterations);
else
     error('The requested encoder is not implemented, please input a different number "enc" ')
end

end





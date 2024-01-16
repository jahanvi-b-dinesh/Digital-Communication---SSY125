function trellis = E123trellis(CL, G1, G2)
% CL: Constraint Length
% G1: Indices of the delays of the first generator polynomial
% G2: Indices of the delays of the second generator polynomial
numInputSymbols = 2;
numOutputSymbols = 4;
numStates = 2^(CL - 1);
nextStates = zeros(numStates,2);
outputs = zeros(numStates,2);
zero_decimal = zeros(1,numStates);
one_decimal = zeros(1,numStates);
G00 = zeros(1,numStates);
G01 = G00;
G10 = zeros(1,numStates);
G11 = G10;
G11 = zeros(1,numStates);
G21 = G11;

for CurrentState=1:numStates
    %initialize register
    reg = de2bi(CurrentState-1, CL-1, 'left-msb'); %binary    
    % calculate next state
    zero_binary = [0 reg(1:CL-2)]; %Input 01
    zero_decimal(CurrentState) = bi2de(zero_binary, 'left-msb');    
    one_binary = [1 reg(1:CL-2)]; %Input 1
    one_decimal(CurrentState) = bi2de(one_binary, 'left-msb');    
    nextStates(CurrentState,:) = [zero_decimal(CurrentState) one_decimal(CurrentState)];
    % calculate output   
    reg = (-2*reg)+1; % 0=>1, 1=>-1   
    delay_G1 = reg(G1);
    G10(CurrentState) = prod(delay_G1);
    G11(CurrentState) = G10(CurrentState)*-1;
    delay_G2 = reg(G2);
    G20(CurrentState) = prod(delay_G2);
    G21(CurrentState) = G20(CurrentState)*-1;
    G10(CurrentState) = (-prod(delay_G1)+1)/2;
    
    G11(CurrentState) = (-G11(CurrentState)+1)/2;
    G20(CurrentState) = (-G20(CurrentState)+1)/2;
    G21(CurrentState) = (-G21(CurrentState)+1)/2;
    
    G00(CurrentState) = bi2de([G10(CurrentState) G20(CurrentState)], 'left-msb');
    G01(CurrentState) = bi2de([G11(CurrentState) G21(CurrentState)], 'left-msb');     
    outputs(CurrentState,:) = [G00(CurrentState) G01(CurrentState)];
end
%Mold results into trellis struct from
trellis = struct('numInputSymbols',numInputSymbols,'numOutputSymbols',numOutputSymbols,...
    'numStates',numStates,'nextStates',nextStates,'outputs',outputs);
end

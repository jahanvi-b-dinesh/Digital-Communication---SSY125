numInputSymbols = 4;
numOutputSymbols = 8;
numStates = 8;
nextStates = zeros(numStates,numInputSymbols);
outputs = zeros(numStates,numInputSymbols);
CL = 5;
reg = zeros(2,3);
for CurrentState = 1:numStates
    for info = 1:numInputSymbols
        %initialize register
        reg(1,:) = de2bi(CurrentState-1,CL-2,'left-msb');
        G1 = de2bi(info-1,2,'left-msb');
        % update registers
        reg(2,2) = bitxor(G1(2),reg(1,1));
        reg(2,3) = bitxor(G1(1),reg(1,2));
        reg(2,1) = reg(1,3);
        % calculate next state
        nextStates(CurrentState,info) = bi2de(reg(2,:),'left-msb');
        % calculate output1
        G0 = reg(1,3);
        outputs(CurrentState,info) = bi2de([G0 G1],'left-msb');        
    end
end
trellis = struct('numInputSymbols',numInputSymbols,'numOutputSymbols',numOutputSymbols,...
    'numStates',numStates,'nextStates',nextStates,'outputs',outputs);
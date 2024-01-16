%% capacity calculation
 %BPSK 1*1/2, QPSK 2*1/2, AMPM 3*2/3
 
function C = calc_capacity(mod)

R=[0.5; 1; 2]; %BPSK 1*1/2, QPSK 2*1/2, AMPM 3*2/31

if mod == 1 % BPSK
    R=0.5;
elseif mod == 2 % QPSK
    R=1;
elseif mod == 3 % AMPM
    R=2;
else
    disp('Capacity modulation???')
end

C = 10*log10((2^R-1)/R);
end

% xline(C, '--r')


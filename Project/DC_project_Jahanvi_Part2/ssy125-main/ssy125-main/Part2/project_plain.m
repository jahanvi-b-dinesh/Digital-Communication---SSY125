% ======================================================================= %
% SSY125 Project
% ======================================================================= %
clc
clear
beep off

% ======================================================================= %
% Simulation Options
% ======================================================================= %
N = 1e6;  % simulate N bits each transmission (one block) 1
maxNumErrs = 100; % get at least 100 bit errors (more is better)
maxNum = 1e6; % OR stop if maxNum bits have been simulated
EbN0 = -1:1:9; % power efficiency range

% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results
mod = 2; % 1: BPSK, 2: QPSK, 3:AMPM
enc = 2; % 0: no encoding, 1,2,3,4: encoders
%num = enc;
rec = 1; % 0: hard, 1: hard viterbi, 2: soft viterbi

%% Uncoded Transmission
for noise = 1:length(EbN0) % use parfor ('help parfor') to parallelize
    totErr = 0;  % Number of errors observed
    num = 0; % Number of bits processed
    while((totErr < maxNumErrs) && (num < maxNum))
        % ===================================================================== %
        % Begin processing one block of information
        % ===================================================================== %
        % [SRC] generate N information bits
        bits = randsrc(1,N,[0 1]);
        
        %bits = [0 1 0 1 1 0 1 1];

        % [ENC] convolutional encoder
        [bits_enc,x_hard,x_soft]=code_data(bits, enc);

        % [MOD] symbol mapper
        symbols = mapper(bits_enc,mod); 

        % [CHA] add Gaussian noise
        y = add_awgn_noise(symbols,EbN0(noise),mod,rec,enc);
        
        %[HR] Hard Receiver and [SR] Soft Recevier
        if rec == 0
            y = demapper(y,mod);
            bits_decoded = receiver(y,x_hard,enc,rec,mod);
            bits_decoded = bits_decoded(1:end-(length(bits_decoded)-length(bits)));
        elseif rec == 1
            y = demapper(y,mod);
            bits_decoded = receiver(y,x_hard,enc,rec,mod);
        elseif rec == 2
            bits_decoded = receiver(y,x_soft,enc,rec,mod);
        end
        

        %% Error Calculation
        BitErrs = length(find((bits_decoded-bits)~=0));
        totErr = totErr + BitErrs;
        num = num + N;
        
    end
    
    BER(noise) = totErr/num;
    
end
BER_coded = BER;


%% Figure


% Plot the theoretical BER

BER_theory = qfunc(sqrt(2*10.^(EbN0/10))); %QPSK

% Plot the BER for the given modulation, encoder and recevier ( Hard, Soft or Uncoded) 

semilogy(EbN0,BER_coded,'-');
hold on;
semilogy(EbN0,BER_theory,'.','MarkerEdgeColor','r');

xlabel('Eb/N0 [dB]');
ylabel('BER');
grid on;
title('BER versus Eb/N0');
legend('upper bound', 'coded System (Simulation)', 'coded System (Theory)');
ylim([1e-4 1])




function [y] = add_awgn_noise(x,EbN0,mod,rec,enc)

% x    : symbols
% EbN0 : noise level
% mod  : modulation type (BPSK=1, QPSK=2, AMPM=3)
% y    : noisy symbols1

if mod==1 % BPSK
    R=log2(2);
elseif mod==2 % QPSK
    R=log2(4);
elseif mod==3 % AMPM
    R=log2(8);
else
    warning('Modulation not valid')
end

%%
Es = mean(abs(x).^2);
snr = 10^(EbN0/10);
if rec==0
    sigma = Es/(snr*0.5*R*2);
    n = sqrt(sigma)*1./sqrt(2)*(randn(1,length(x)) + 1i*randn(1,length(x))); 
elseif (rec == 1 || rec == 2) && (enc==1 || enc==2 || enc==3)
    sigma = Es/(snr*0.5*R*2*0.5);
    n = sqrt(sigma)*1./sqrt(2)*(randn(1,length(x)) + 1i*randn(1,length(x)));
elseif rec == 2 && (enc==4)
    sigma = Es/(snr*0.5*R*2/3);
    n = sqrt(sigma)*1/sqrt(4)*(randn(1,length(x)) + 1i*randn(1,length(x)));
end
y=x+n;
end

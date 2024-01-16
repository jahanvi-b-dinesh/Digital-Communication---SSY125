function P = calc_ub(num)
% num: which encoder you want to plot the upper bound

EbN0 = -1:1:9; % power efficiency range1
n=10;

switch num
    case 1
        trellis = E123trellis(3, [2], [1 2]);
        spect = distspec(trellis,n);
        w = spect.weight;
        d = spect.dfree:(n+spect.dfree-1);

    case 2
        trellis = E123trellis(5, [2 3 4], [2 3]);
        spect = distspec(trellis,n);
        w = spect.weight;
        d = spect.dfree:(n+spect.dfree-1);

    case 3
        trellis = E123trellis(5, [3 4], [1 3 4]);
        spect = distspec(trellis,n);
        w = spect.weight;
        d = spect.dfree:(n+spect.dfree-1);

    case 4
        run E4trellis.m;
        spect = distspec(trellis,n);
        w = spect.weight;
        d = spect.dfree:(n+spect.dfree-1);
end

P=zeros(length(EbN0));
for h = 1:length(EbN0) % use parfor ('help parfor') to parallelize
    snr = 10^(EbN0(h)/10);
    inside = (2.*d.*0.5.*snr);
    P(h) = sum(w .* qfunc(sqrt(inside)));
end

%% Add this to the main file to plot upper bound 
figure; 
semilogy(EbN0, P, '--'); 
ylim([1e-4 1]); grid on;

end
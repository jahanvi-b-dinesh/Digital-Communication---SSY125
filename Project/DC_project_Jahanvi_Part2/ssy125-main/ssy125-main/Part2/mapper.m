function symbols = mapper(bits,modulation)

BPSK = [-1 1];
QPSK = [(+1 + 1i) (-1 + 1i) (+1 - 1i) (-1 - 1i)]/sqrt(2);
AMPM = [(1 + -1i) (-3 + 3i) (1 +  3i) (-3 - 1i) (3 - 3i) (-1 + 1i) (+3 + 1i) (-1 - 3i)]/sqrt(10);

switch modulation
    case 1
        symbols = 2*bits-1;
    case 2
        packets_buffer = bi2de((buffer(bits,2))','left-msb');
        symbols = QPSK(packets_buffer+1);
    case 3
        packets_buffer = bi2de((buffer(bits,3))','left-msb');
        symbols = AMPM(packets_buffer+1);
    otherwise
        error('mapper???')
end

end

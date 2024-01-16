function bits_decoded = receiver(bits,x,enc,rec,mod)

if rec==0 % Uncoded
    bits_decoded = bits;
elseif rec==1 %Hard Viterbi1
    bits_decoded = Hardviterbi(bits,x,enc);

elseif rec==2 %Soft Viterbi
     bits_decoded = Softviterbi(bits,x,enc,mod);

else
    error('Wrong receiver');
end
end







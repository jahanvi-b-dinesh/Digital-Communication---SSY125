function [bits_enc,x_hard,x_soft]=code_data(bits, num)

% num defines which encoder to use
% 0: no encoding
% 1,2,3

switch num
    case 0
        
        bits_enc=bits;
        
        % Output codeword used in the Hard and Soft viterbi1
        % For the uncoded transmission, hard or soft viterbi is not used.
        
        x_hard=[];
        x_soft=[];
        
    case 1
        
        bits_conv = [bits];
        
        % Generator matrix g1 and g2 
        
        d1 = [1,0,1]; %5 , g1
        d2 = [1,1,1]; %7 , g2
        
        % Output codeword used in the Hard and Soft viterbi
        
        x_hard = [0 0;1 1;0 1;1 0;1 1;0 0;1 0;0 1];
        x_soft = [0 0 1 1 0 1 1 0 1 1 0 0 1 0 0 1];
        
    case 2
        
        bits_conv = [bits];
        % Generator matrix g1 and g2 
        
        d1 = [1,0,1,1,1]; %27 , g1 
        d2 = [1,0,1,1,0]; %26 , g2
        
        % Output codeword used in the Hard and Soft viterbi
        
        x_hard = [0 0; 1 0; 1 1; 0 1; 1 1; 0 1; 0 0; 1 0; 0 0; 1 0; 1 1; 0 1; 1 1; 0 1; 0 0; 1 0;1 1;0 1;0 0 ;1 0;0 0;1 0;1 1;0 1;1 1;0 1;0 0;1 0;0 0;1 0;1 1;0 1];
        x_soft = [0 0 1 0 1 1 0 1 1 1 0 1 0 0 1 0 0 0 1 0 1 1 0 1 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 0 0 1 0 1 1 0 1 1 1 0 1 0 0 1 0 0 0 1 0 1 1 0 1];
        
    case 3
        
        bits_conv = [bits];
        
        % Generator matrix g1 and g2
      
        d1 = [1,0,0,1,1]; %23 , g1
        d2 = [1,1,0,1,1]; %33 , g2
        
        % Output codeword used in the Hard and Soft viterbi
        
        x_hard = [0 0; 1 1; 1 1; 0 0; 0 0; 1 1; 1 1; 0 0; 0 1; 1 0; 1 0; 0 1; 0 1; 1 0; 1 0; 0 1; 1 1; 0 0; 0 0; 1 1; 1 1; 0 0; 0 0; 1 1; 1 0; 0 1; 0 1; 1 0; 1 0; 0 1; 0 1; 1 0];
        x_soft = [0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 0 0 1 0 1 1 0 1 0 0 1 0 1 1 0];
        
    case 4
        
        % Genetor matrix g1, g2, and g3
        
        % g1 = [0010] 2
        % g2 = [0100] 4
        % g3 = [1001] 11
        
        % Output codeword used in the Hard and Soft viterbi
        
        x_soft =  [0 0 0 0 1 0 0 0 1 0 1 1 1 0 0 1 1 0 1 0 1 1 1 1 0 1 0 0 0 0 0 1 1 0 0 1 1 1 0 1 0 0 1 1 1 1 0 1 0 0 1 0 1 1 0 0 0 0 1 0 1 0 1 1 1 1 1 0 0 1 1 0 0 1 1 0 0 1 0 1 0 0 0 0 1 1 1 1 0 1 1 1 0 1 0 0];
        x_hard = [];
        
end

% encodes the data for encoder 1, 2, and 3

if num==1 || num==2 || num==3
    c1 = mod(conv(bits_conv,d1),2);
    c2 = mod(conv(bits_conv,d2),2);
    b = length(d1)-1;
    c1 = c1(1:end-b);
    c2 = c2(1:end-b);
    bits_enc = [c1;c2];
    bits_enc = reshape(bits_enc,1,[]);
end

% encodes the data for encoder 4

if num==4
    
    % Initialization vectors 
    
    d = [0 0 0];
    c2 = bits(1:2:end); 
    c3 = bits(2:2:end);
    c1 = zeros(length(bits)/2,1);
    
    % Loop thorugh the different states and calculates codeword c1

    for i=1:length(bits)/2
        c1(i) = d(3);
        d(3) = bitxor(d(2),bits(2*i-1));
        d(2) = bitxor(d(1),bits(2*i));
        d(1) = c1(i);
    end
    
    % calculate codeword c2, c3 and finalize the encoding from encoder 4     
    
    bits_enc = zeros(1,length(c1)+length(c2)+length(c3));
    bits_enc(1:3:end) = c1;
    bits_enc(2:3:end) = c2;
    bits_enc(3:3:end) = c3;
    bits_enc = bits_enc(:); 
end


end
function [freq] = get_freqs(A,Max)
%CREATE_HIST Returns a histogram of the input.
%   Returns an L x 1 vector where the idx represents the (original value+1)
%   and the value at that index is the number of occurences of that value.
%   that is the value at freq(1,1) is the number of times 0 occured in A.
%   And freq(100,1) is the number of times 99 occured in A.
%   A can be up to 2 dimentional

%   A is the input array or matrix, Max is the maximum value A can take.
%   this defaults to max(A)

arguments 
    A
    Max = max(A)
end


% get frequencies
    freq = zeros(Max,1);
    for i = 1:Max
        freq(i) = sum(A==i,"all");
        
    end

freq = sum(freq,2);
end

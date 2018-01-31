function [ek] = buildstraink(NM, ABD)
%Calculate the epsilon k matrix from the ABBD matrix
ek = inv(ABD) * NM;
end

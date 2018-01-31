function [zmat] = buildZmat(t)
%Create the Z matrix needed to compute the ABBD matrix for the composite
global n %number of plies

totalt = 0; %Total thickness of beam

%Calculate the total thickness of the beam
for i = 1:n
    totalt = t(i) + totalt; %Total thickness of beam
end
%Designate first Z value
z(1) = -totalt/2;

%For loop to create the remainder of the Z matrix
for k = 2:n
    z(k) = z(k-1)+t(k-1);
end


z(n+1) = totalt/2;

zmat = 1/1000*z;
end


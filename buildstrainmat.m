function [strainmat] = buildstrainmat(ekmat, zmat)
global n
%For loop to calculate the strains on each ply of the composite
for i = 1:n+1
    strain(1,i) = ekmat(1) + zmat(i)*ekmat(4);
    strain(2,i) = ekmat(2) + zmat(i)*ekmat(5);
    strain(3,i) = ekmat(3) + zmat(i)*ekmat(6);
end
strainmat = strain;
end

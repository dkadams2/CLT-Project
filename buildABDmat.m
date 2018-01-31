function [ABD] = buildABDmat(Qbar, z)
global n

%Initialize A as zero, then use for loop to calculate the A portion of the
%ABBD matrix
A = 0;
for i = 1:n
   A = Qbar(:,:,i)*((z(i+1)-(z(i))))+ A ;
end

%Initialize B as zero, then use for loop to calculate the B portion of the
%ABBD matrix
B = 0;
for i = 1:n
   B = Qbar(:,:,i)*(((z(i+1))^2-((z(i)))^2))+ B ;
end

B = .5*B;

%Initialize  as zero, then use for loop to calculate the D portion of the
%ABBD matrix
D = 0;
for i = 1:n
   D = Qbar(:,:,i)*(((z(i+1))^3-((z(i)))^3))+ D ;
end
D = (1/3)*D;

ABD = [A, B; B, D];

end
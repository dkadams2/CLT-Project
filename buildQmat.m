function [Qmat] = buildQmat(CompPlies)
E1 = 10e8*CompPlies(1);  %Designate the E1 value of the ply and convert to GPa
E2 = 10e8* CompPlies(2); %Designate the E2 value of the ply and convert to GPa   
v1 = CompPlies(3);       
v2 = CompPlies(4);
G12 = 10e8*CompPlies(5); %Designate teh G12 value of the ply and convert to GPa

 %Calculate Q Matirce values and build matrix
 Q11 = E1/(1-v1*v2);
 Q12 = (v1*E2)/(1-v1*v2);
 Q13 = 0;
 Q21 = Q12;
 Q22 = E2/(1-v1*v2);
 Q23 = 0;
 Q31 = 0;
 Q32 = 0;
 Q33 = G12;
 
Qmat = [Q11, Q12, Q13;
        Q21, Q22, Q23;
        Q31, Q32, Q33];
end
function [Qbar] = buildQbar(Qmat,Angle)
%Take in the Q matrix and rotate it into the global frame
theta = Angle*(pi/180);  %Assign theta to the angle of each ply
Q11 = Qmat(1,1);
Q12 = Qmat(1,2);
Q22 = Qmat(2,2);
Q66 = Qmat(3,3);

%Rotation Matrix
T = [cos(theta)^4, sin(theta)^4, 2*cos(theta)^2*sin(theta)^2, 4*cos(theta)^2*sin(theta)^2;
sin(theta)^4, cos(theta)^4, 2*cos(theta)^2*sin(theta)^2, 4*cos(theta)^2*sin(theta)^2;
cos(theta)^2*sin(theta)^2, cos(theta)^2*sin(theta)^2, cos(theta)^4+sin(theta)^4, -4*cos(theta)^2*sin(theta)^2; 
cos(theta)^2*sin(theta)^2, cos(theta)^2*sin(theta)^2, -2*cos(theta)^2*sin(theta)^2, (cos(theta)^2-sin(theta)^2)^2;
cos(theta)^3*sin(theta), -cos(theta)*sin(theta)^3, cos(theta)*sin(theta)^3-cos(theta)^3*sin(theta), 2*(cos(theta)*sin(theta)^3-cos(theta)^3*sin(theta));
cos(theta)*sin(theta)^3, -cos(theta)^3*sin(theta), cos(theta)^3*sin(theta)-cos(theta)*sin(theta)^3, 2*(cos(theta)^3*sin(theta)-cos(theta)*sin(theta)^3);]; 

Q = [Q11; Q22; Q12; Q66];

Qf = T*Q; %Qf is the resultant Q of the multiplication of Q and the rotation matrix

Qbar = [Qf(1), Qf(3), Qf(5);
        Qf(3), Qf(2), Qf(6);
        Qf(5), Qf(6), Qf(4)];
end
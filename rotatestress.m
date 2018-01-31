function [stresstop, stressbot] = rotatestress(stresstop, stressbot, thetamat)

%Rotate the stress into sigma1 and sigma2
global n

 for j = 1:n
     theta = pi/180*thetamat(j); %Angle of each ply
     
     T = [(cos(theta))^2, (sin(theta))^2, 2*cos(theta)*sin(theta);
          (sin(theta))^2, (cos(theta))^2, -2*cos(theta)*sin(theta);
          -cos(theta)*sin(theta), cos(theta)*sin(theta), (cos(theta))^2 - (sin(theta))^2];
 
     stresstop(:,j) = T*stresstop(:,j); %multiply the stresstop matrix by the rotation matrix
     stressbot(:,j) = T*stressbot(:,j); %multiply the stressbot matrix by the rotation matrix
 end
 
function [stresstop,stressbot] = buildstressmat(Qbar, strainmat, thetamat)

global n
%For loop to create stress matrices for the top and bottom of the plies
for i = 1:n
    stresstop(:,i) = Qbar(:,:,i)*strainmat(:,i);    %Stress on top of each ply
    stressbot(:,i) = Qbar(:,:,i)*strainmat(:,i+1);  %Stress on the bottom of each ply
end


end
function [failure] = MaxStrain(stresstop, stressbot, CompPlies)
global n


%From rotated stress matrix, assign values for top and bottom stresses

%Top Stress matrix (converted to GPa)
sigmaT1 = stresstop(1,:)/1000;
sigmaT2 = stresstop(2,:)/1000;
tauT = stresstop(3,:)/1000;

%Bottom Stress matrix (converted to GPa)
sigmaB1 = stressbot(1,:)/1000;
sigmaB2 = stressbot(2,:)/1000;
tauB = stressbot(3,:)/1000;


%Determine Failure for TOP of Plies
for i = 1:n
    %Determine Strength values
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
   %NEED TO FIGURE OUT HOW TO SOLVE FOR THESE %Solve for max strain values
    eLp = SLP/CompPlies(i,1);
    eLm = SLM/CompPlies(i,1);
    eTp = STP/CompPlies(i,2);
    eTm = STM/CompPlies(i,2);
    eLT = SLT/CompPlies(i,5);

    %Solve for actual strains on each ply
    eT1 = sigmaT1(i)/CompPlies(i,1);
    eT2 = sigmaT2(i)/CompPlies(i,2);
    gammaT12 = tauT(i)/CompPlies(i,3);

if (eT1<eLp && eT1>-eLm)
    failuretop(i) = 0;
    if (eT2<eTp && eT2>-eTm)
        failuretop(i) = 0;
        if (abs(gammaT12)<eLT)
            failuretop(i) = 0;
        else
            failuretop(i) = 1;
        end
    else
        failuretop(i) = 1;
    end
else
    failuretop(i) = 1;
end

end

%Determine Failure for BOTTOM of Plies
for i = 1:n
    %Determine Strength values
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
   %NEED TO FIGURE OUT HOW TO SOLVE FOR THESE %Solve for max strain values
    eLp = SLP/CompPlies(i,1);
    eLm = SLM/CompPlies(i,1);
    eTp = STP/CompPlies(i,2);
    eTm = STM/CompPlies(i,2);
    eLT = SLT/CompPlies(i,5);

    %Solve for actual strains on each ply
    eB1 = sigmaB1(i)/CompPlies(i,1);
    eB2 = sigmaB2(i)/CompPlies(i,2);
    gammaB12 = tauB(i)/CompPlies(i,3);

if (eB1<eLp && eB1>-eLm)
    failurebot(i) = 0;
    if (eB2<eTp && eB2>-eTm)
        failurebot(i) = 0;
        if (abs(gammaB12)<eLT)
            failurebot(i) = 0;
        else
            failurebot(i) = 1;
        end
    else
        failurebot(i) = 1;
    end
else
    failurebot(i) = 1;
end

end

%Add the top and bottom failure vectors together.
failuretotal = failuretop + failurebot;

%For loop to tell which plies fail by strain.
for i = 1:n;
    if failuretotal(i)>0
        failure(i) = 1;
    else
        failure(i) = 0;
    end
end
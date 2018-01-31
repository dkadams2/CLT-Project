function [failure] = MaxStress(stresstop, stressbot, CompPlies)

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

%Determine MaxStress criteria for TOP of plies
for i =1:n
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
    if (sigmaT1(i)<SLP && sigmaT1(i)>-SLM)
        failuretop(i) = 0;
        if(sigmaT2(i)<STP && sigmaT2(i)>-STM)
            failuretop(i) = 0;
            if(tauT<SLT)
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
    failuretotal = failuretop;
end

%Determine MaxStress for BOTTOM of plies
for i =1:n
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
    if (sigmaB1(i)<SLP && sigmaB1(i)>-SLM)
        failurebot(i) = 0;
        if(sigmaB2(i)<STP && sigmaB2(i)>-STM)
            failurebot(i) = 0;
            if(tauB<SLT)
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
    failuretotal = failurebot;
end

failuretotal = failuretop + failurebot;

%Output a vector that shows which plies fail
for i = 1:n;
    if failuretotal(i)>0
        failure(i) = 1;
    else
        failure(i) = 0;
    end
end
    
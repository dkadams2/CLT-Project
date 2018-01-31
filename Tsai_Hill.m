function [failure] = Tsai_Hill(stresstop, stressbot, CompPlies)

global n

%From rotated stress matrix, assign values for top and bottom stresses

%Top Stress matrix
sigmaT1 = stresstop(1,:);
sigmaT2 = stresstop(2,:);
tauT = stresstop(3,:);

%Bottom Stress matrix
sigmaB1 = stressbot(1,:);
sigmaB2 = stressbot(2,:);
tauB = stressbot(3,:);

%For loop to determine SL, ST, and SLT for Tsai-Hill eqn on Top of Plies
for i = 1:n
    
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
    %Determine which strength values to use. Use the larger one for
    %increased factor of safety.
    if SLP<SLM
        SL = SLP;
      else
        SL = SLM;
    end
    
    if STP<STM
        ST = STP;
     else
        ST = STM;
    end
    
    %Convert the stresses on top of the plies to GPa
    sigmaT1(i) = sigmaT1(i)/1000; 
    sigmaT2(i) = sigmaT2(i)/1000; 
    
    %Do the Tsai-Hill Calculation.
    TsaiHill = ((sigmaT1(i))^2)/(SL)^2 - ((sigmaT1(i))*(sigmaT2(i)))/(SL*SL) + ((sigmaT2(i))^2)/(ST^2) + ((tauT(i))^2)/(SLT*SLT);
   
    %From calculation, determine if the ply failed or not. (1 = failed, 0 = not failed)
    if TsaiHill<1
        failuretop(i) = 0;
    else
        failuretop(i) = 1;
    end
end

%For loop to determine SL, ST, and SLT for Tsai-Hill eqn on bottom of Plies
for i = 1:n
    
    SLP = CompPlies(i,6);
    SLM = CompPlies(i,7);
    STP = CompPlies(i,8);
    STM = CompPlies(i,9);
    SLT = CompPlies(i,10);
    
    %Determine which strength values to use. Use the larger one for
    %increased factor of safety.
    if SLP<SLM
        SL = SLP;
      else
        SL = SLM;
    end
    
    if STP<STM
        ST = STP;
     else
        ST = STM;
    end
    
    %Convert stresses to GPa
    sigmaB1(i) = sigmaB1(i)/1000; 
    sigmaB2(i) = sigmaB2(i)/1000; 
    
    TsaiHill = ((sigmaB1(i))^2)/(SL)^2 - ((sigmaB1(i))*(sigmaB2(i)))/(SL*SL) + ((sigmaB2(i))^2)/(ST^2) + ((tauB(i))^2)/(SLT*SLT);

    if TsaiHill<1
        failurebot(i) = 0;
    else
        failurebot(i) = 1;
    end
end

%Add the top and bottom failure vectors together to determine which plies fail overall
failuretotal = failuretop + failurebot;

for i = 1:n;
    if failuretotal(i)>0
        failure(i) = 1;
    else
        failure(i) = 0;
    end
end




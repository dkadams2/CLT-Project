function [PlyFailure, Failchoice] = FailureCriteria(stresstop, stressbot, CompPlies)
%Create a dialog selection box to allow user to select which failure
%criteria to evaluate the composite with

Failchoice = menu('Select a Failure Criteria', 'Maximum Stress','Maximum Strain', 'Tsai-Hill');

 switch Failchoice
     case 1
         %Call the Max Stress function to calculate which plies fail
         [PlyFailure] = MaxStress(stresstop, stressbot, CompPlies);
       
     case 2   
         %Call the Max Strain function to calculate which plies fail
         [PlyFailure] = MaxStrain(stresstop, stressbot, CompPlies);
         
     case 3
         %Call the Tsai-Hill function to calculate which plies fail
         [PlyFailure] = Tsai_Hill(stresstop, stressbot, CompPlies);
         
 end
         %Function returns PlyFailure, which is a vector of 1's or 0's that
         %correspond to each ply. If the ply's value is a 1 it has failed,
         %if it is a 0 it has not failed.
 end

 
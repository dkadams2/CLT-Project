function [] = output(ABDmat, stresstop, stressbot, strainmat, CompPlies, PlyFailure, filename,failchoice)
fID = fopen(char(filename), 'w+');

%Transpose the CompPlies matrix so that it exports correctly formatted
CompPlies = transpose(CompPlies);

%Title
FORM = 'CLT Output: %s';
x = char(filename);
fprintf(fID, FORM, x);

%Ply Properties E1, E2, v1, v2, G12, SLP, SLM, STP, STM, SLT
FORM = '\n\nComposite Properties (GPa): \nE1\t\t\tE2\t\t\tv1\t\t\tv2\t\t\tG12\t\t\tSLP\t\t\tSLM\t\t\tSTP\t\t\tSTM\t\t\tSLT\n' ;
fprintf(fID, FORM);
FORM = '%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\n' ;
fprintf(fID, FORM, CompPlies);

%ABBD Matrix for Composite
FORM = '\n\nABBD Matrix\n';
fprintf(fID, FORM);
FORM = '%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\t%3.3E\n';
fprintf(fID, FORM, ABDmat);

%Stresses on Top of Plies
FORM = '\n\nStresses on Top of Plies (MPa)\n SigmaXTOP\t\tSigmaYTOP\t\tTauXYTOP\n';
fprintf(fID, FORM);
FORM = ' %3.3E\t\t%3.3E\t\t%3.3E\n';
fprintf(fID, FORM, stresstop);

%Stresses on Bottom of Plies
FORM = '\n\nStresses on Bottom of Plies (MPa)\n SigmaXBOT\t\tSigmaYBOT\t\tTauXYBOT\n';
fprintf(fID, FORM);
FORM = ' %3.3E\t\t%3.3E\t\t%3.3E\n';
fprintf(fID, FORM, stressbot);

%Strains on Each Ply
FORM = '\n\nStrains on Each Ply\nepsilonX\t\tepsilonY\t\tgammaXY\n';
fprintf(fID, FORM);
FORM = ' %3.3E\t\t%3.3E\t\t%3.3E\n';
fprintf(fID, FORM, strainmat);

%Ply Failure Results
switch failchoice
    case 1
        FORM = '\n\nPly Failure According to Max Stress Criterion (Starting with Top ply)\n\t\t     0 = No Failure, 1 = Failure\n\n';
        fprintf(fID, FORM);
        FORM = '%1.0f\t';
        fprintf(fID, FORM, PlyFailure);
    case 2
        FORM = '\n\nPly Failure According to Max Strain Criterion (Starting with Top ply)\n\t\t     0 = No Failure, 1 = Failure\n\n';
        fprintf(fID, FORM);
        FORM = '%1.0f\t';
        fprintf(fID, FORM, PlyFailure);
    case 3
        FORM = '\n\nPly Failure According to Tsai-Hill Criterion (Starting with Top ply)\n\t\t     0 = No Failure, 1 = Failure\n\n';
        fprintf(fID, FORM);
        FORM = '%1.0f\t';
        fprintf(fID, FORM, PlyFailure);
end


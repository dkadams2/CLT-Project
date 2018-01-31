%For: Dr. Fullwood
%Name: Derrik Adams
%Date: April 14, 2015
%Matlab CLT Project Main File
%This program allows a user to create a composite by varying the number of plies, 
%its fiber materials,matrix material, etc... and then calculates the resultant properties
%of each ply in the composite. It then allows the user to input the desired
%stresses on the composite and select a failure criteria. It then
%calculates the appropriate resulting stresses and determines, according
%to the criteria selected, which plies in the composite will fail under the
%input stresses and outputs all of the necessary, calculated data to file.

clc;
clear;

%Call function to get number of plies.
global n; %number of plies in composite
n = askplies();

%Call function to build UserInterface Table and get information from it
data = SelectionTable();
tmat = data(:,3); %matrix of thickness for each ply

%Calculate Composite Matrix for plies creates a matrix where each row is
%the properties of a ply
for i=1:n
   CompPlies(i,:) = Properties(data(i,:)); 
end

%Call Function to build matrix of Q matrices
Qmat = zeros(3,3);
for j=1:n
Qmat(:,:,j) = buildQmat(CompPlies(j,:));
end

%Call Function to build Qbar matrix and declare Angle variable
Qbar = zeros(3,3);
for j=1:n
Angle = data(j,4);
Qbar(:,:,j) = buildQbar(Qmat(:,:,j), Angle);
end

%Get NM matrix from user
NM = askforces();

%Call Zmat function to build matrix of Z values
for k = 1:n
zmat = buildZmat(tmat);
end

%Call buildABD function to build ABD matrix
ABDmat = buildABDmat(Qbar, zmat);

%Call buildstraink to build the strain and K matrix
ekmat = buildstraink(NM, ABDmat);

%Call buildstrainmat to build the strain matrix
strainmat = buildstrainmat(ekmat, zmat);

%Call buildstressmat to build stress matrix
thetamat = data(:,4);
[stresstop, stressbot] = buildstressmat(Qbar, strainmat,thetamat);

%Rotate the Stress matrices back into global frame.
[stresstoprotated, stressbotrotated] = rotatestress(stresstop, stressbot, thetamat);

%Ask user what failure criteria to use and then calculate it accordingly
[PlyFailure,Failchoice] = FailureCriteria(stresstoprotated, stressbotrotated, CompPlies);

%Ask user to enter filename for the output data
filename = askfilename();

%Send data to output function to export to a file
output(ABDmat,stresstop, stressbot, strainmat, CompPlies, PlyFailure, filename,Failchoice);




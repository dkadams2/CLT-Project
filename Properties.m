function [output] = Properties(data)
%Matrix for Fiber Properties
%Fiber                                                Boron    HMS     AS     T3000   KEV   S-G    E-G  
%1)Longitudinal Modulus E1f (e^6 psi)                  58      55      31      32.0    22   12.4   10.6  
%2)Tansverse Modulus E2f (e^6 psi)                     58      .9      2.0     2.0    .6    12.4   10.6
%3)Longitudinal shear modulus G1f (e^6 psi)            24.2    1.1     2.0     1.3    .42   5.17   4.37
%4)Transverse shear modulus G2f (e^6 psi)              24.2    .7      1.0     .7     .22   5.17   4.37
%5)Longitudinal Poisson's Ratio v12                    .20     .2      .20    .20     .35   .20    .22
%6)Transverse Poisson's Ration v21                     .20     .00327 .0129  .0125   .00954 .2     .22
%7)Longitudinal tensile strength (ksi)                 600     250     350    350     400   600    400
%8)Longitudinal compression strength (ksi)             700     200     260    300      75
%9)Shear strength (ksi)                                100
%10)Fiber Diameter 
%11)Density
%12)ef1

%Fiber Properties in GPa 
%               Boron(1)    HMS(2)      AS(3)  Web Prop  T3000(5)    KEV(6)      S-G(7)    E-G(8)
FProp =       [399.89603, 379.21175, 213.73753,  9.5,   220.63229, 151.68470,  85.49501, 73.08445;   %1)E1f
               399.89603, 6.20528,   13.78952,    9.5,   13.78952,   4.13686,   85.49501, 73.08445;   %2)E2f
               166.85317, 7.58423,   13.78952,    6.64,  8.96319,    2.89580,   35.64590, 30.13010;   %3)G1f
               166.85317, 4.82633,   6.89476,      0,    4.82633,    1.51685,   35.64590, 30.13010;   %4)G2f
               .20,       .20,         .20,       .03,    .20,        .35,       .20,       .22;      %5)v12
               .20,       .00327,     .0129,       0,     .0125,      .00954,    .2,        .22;      %6)v21
               4.13686,  .72369,     2.41317,      0,    2.41317,    2.75790,   4.13686,  2.75790;    %7)LTS 
               4.82633,   .37895,    1.79264,      0,    2.06843,    .51712,      0,         0;       %8)LCS 
               .68948,      0.0,       0.0,        0,       0,          0,        0,         0;       %9)Shear Strength 
               .00014224, 7.62e-6,   7.62e-6,      0,     7.62e-6,    1.1684e-5, 9.144e-6, 9.144e-6;  %10)Fiber Diameter(m)
               2629591,   1937593,   1743834,      0,     1771514,    1467035,    2491191,  2491191;  %11)Density(g/m^3)
               .008,      .007,       .018,        0,     .014,       .024,     .057,    .048;];      %12)ef1
            
%Matrix Properties(English Units):
%Matrix: LM IMLS IMHS HM Polyimide PMR 
 % Modulus(e6 psi): .32 .50 .50 .75 .50 .47 
 % Poisson's Ratio: .43 .41 .35 .35 .35 .36
 % Tensile Strength (ksi): 8 7 15 20 15 8
 % Compression Strength(ksi): 15 21 35 50 30 16
 % Shear Strength(ksi): 8 7 13 15 13 8
 % Tensile Fracture Strain: 8.1 1.4 2.0 2.0 2.0 2.0
 % Compressive Fracture Strain: 15 4.2 5.0 5.0 4.0 3.5
 % Shear Fracture Strain: 10 3.2 3.5 4.0 3.5 5.0

 %Matrix Properties (GPa)
 %              LM       IMLS      IMHS     HM     Polyimide   PMR
MProp =     [2.20632,  3.44738,  3.44738, 5.17107, 3.44738,  3.24054;  %1)Em 
              .43,        .41,     .35,     .35,     .35,     .36;     %2)vm
             .05516,      .04826, .10342,  .13789,  .10342,   .05516;  %3)Tensile strength 
             .10342,    .14479,   .24132,  .34474,  .20684,   .11032;  %4)Compression Strength 
             .05516,     .04826,  .08963,  .10342,  .08963,   .05516;  %5)Shear Strength 
             .081,       .014,     .02,    .02,      .02,     .02;     %6)Tensile Fracture Strain
              .15,       .042,      .05,   .05,      .04,     .035;    %7)Compressive Fracture Strain
              .10,       .032,     .035,   .04,      .035,    .05;     %8)Shear Fracture Strain
            1162556,   1273276,  1217916, 1245596, 1217916, 1217916];  %9)Density (g/m^3)
          
 %Define Fiber Properties 
 Fmat = data(1);
 E1f = FProp(1,Fmat);
 E2f = FProp(2,Fmat);
 G1f = FProp(3,Fmat);
 G2f = FProp(4,Fmat);
 v1f = FProp(5,Fmat);
 v2f = FProp(6,Fmat);
 LTSf = FProp(7,Fmat);  %Longitudinal Tensile Strength of Fibers (SLf+)
 ef1 = FProp(12, Fmat); %Max Longitudinal Tensile Strain of fiber
 
 %Define Matrix Properties 
 Mmat = data(2);
 Em = MProp(1,Mmat);
 vm = MProp(2,Mmat);
 STm = MProp(3,Mmat); 
 SCm = MProp(4,Mmat);
 SLTm = MProp(5,Mmat);
 emT = MProp(6, Mmat);

 %If statement used to approximate the web properties on the I-beam
 if E1f == 9.5
    output = [9.5, 9.5, .033, .0001, 6.64, 0, 0, 0, 0, 0];
 else
 
 %Calculate Composite Properties
vff = data(5);      %volume fraction for fibers
vfm = 1-vff;        %volume fraction for matrix
Gm = Em/(2*(1+vm)); %Shear modulus for matrix

E1c = E1f*vff+Em*vfm;                                     %E1 Composite
E2c = Em*((1-(vff^.5))+(vff^.5)/(1-(vff^.5)*(1-Em/E2f))); %E2 Composite
v1c = v1f*vff+vm*vfm;                                     %v1 Composite
v2c = v2f*vff+vm*vfm;                                     %v2 Composite
G12 = Gm*((1-vff^.5)+ (vff^.5)/(1-(vff^.5)*(1-Gm/G1f)));  %G12 Composite

 %Calculate composite strengths
Smf1 = Em*ef1;
Sfm1 = E1f*emT;

ds = sqrt(4*vff/pi);        %d/s
F = 1/(ds*(Em/E2f-1)+1);    
Fs = 1/(ds*(Gm/G1f-1)+1);   

STP = E2c*STm/(Em*F);       %Longitudinal Tensile Strength of Composite
SLP = LTSf*vff + Smf1*vfm;  %Transverse Tensile Strength of Composite

eTP = STP/E2c;          %Max Transverse strain of Composite
SLM = E1c*eTP/v1c;      %Longitudinal Compressive Strength of Composite
STM = SCm;              %Transverse Compressive Strength of Composite
SLT = G12*SLTm/(Gm*Fs); %Max Shear strain of Composite

output = [E1c, E2c, v1c, v2c, G12, SLP, SLM, STP, STM, SLT];
 end
      
end
 


          
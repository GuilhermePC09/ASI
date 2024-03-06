%% Initialisation TP Bacs, 
% Ense3 GRENOBLE-INP 

clear all
close all
clc

% paramétres du système
a=25*10^(-2);
b=34.5*10^(-2);
c=10*10^(-2);
w=3.5*10^(-2);
R=36.4*10^(-2);
L=35*10^(-2);
H1max=35*10^(-2);
H2max=35*10^(-2);
H3max=35*10^(-2);

% contrainte sur la commande
Qmax=1.4e-4; %m^3/s 

% paramétres alpha_i et C_i (Débit sortant = C_i*H_i^(alpha_i)) MAJ NACIM MESLEM Dec 2021

C1=2.0216e-04;  %Pour H autour de 15cm (MAQUETTE 1)
C2=2.2543e-04;
C3=2.0870e-04;

Alfa1=0.3290;
Alfa2=0.3887;
Alfa3=0.3363;

 
% C1=2.8799e-04;   %Pour H autour de 15cm (MAQUETTE 2)
% C2=2.7891e-04;
% C3=3.1969e-04;
% 
% Alfa1=0.4534;
% Alfa2=0.4524;
% Alfa3=0.5128;

% C1=2.2008e-04; %Pour H autour de 15cm (MAQUETTE 3)
% C2=2.5491e-04;
% C3=2.0131e-04;

% Alfa1=0.4631;
% Alfa2=0.5411;
% Alfa3=0.3990;

Alfa=[Alfa1 Alfa2 Alfa3];
CC=[C1 C2 C3];

% Niveaux à l'équilibre (point de fonctionnement)
H30=0.15;

Q0 = 1.2 * 10^-4; % à compléter (expression littérale en fonction de H30)
H10 = 0.1473; % à compléter (expression littérale en fonction de Q0)
H20 = 0.1574; % à compléter (expression littérale en fonction de Q0)


%%% Point de fonctionnement:
H0=[H10;H20;H30]

%%
% Sections transversalles aux point de fonctionnement
S1=a*w;
S2=w*(c+H20/L*b);
S3=w*sqrt(R^2-(R-H30)^2);


%% à completer
% Les matrices du systéme linéarisé
A=[() 0 0; ]; 
B=[(1/S1); 0; 0];
C=[0 0 1];
D=zeros(3,1);

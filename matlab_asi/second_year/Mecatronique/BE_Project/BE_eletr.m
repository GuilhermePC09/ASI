%% BE Commande vectorielle d’un moteur synchrone pour vélo électrique intelligent
% PIFFER CHRISTO Guilherme
close all;
clear;

%% Paramètre moteur, vélo et cycliste
Vnom = 36;
Rs = 0.124;
Ls = 0.0021;
lambm = 0.0744;
Np = 52;
Jm = 0.0028;
M = 92;
Rw = 0.33;
Rpp = 36/16;
Jt = M*Rw^2;
ca = 0.18;

s = 0.07;
g = 9.81;

assist = 2;
%% Modele du moteur
A = [-Rs/Ls 0 0 ; 0 -Rs/Ls -(Np*lambm)/(2*Ls) ; 0 (3*Np*lambm)/(4*Jt) 0];
B = [1/Ls 0 ; 0 1/Ls ; 0 0];
C = [1 1 0];
D = 0;

%% Simulation Simulink
sim("BE_simu",[0 10]);
sim("BE_simu2",[0 10]);
sim("BE_simu3",[0 10]);
sim("BE_simu4",[0 100]);
sim("BE_simu5",[0 100]);

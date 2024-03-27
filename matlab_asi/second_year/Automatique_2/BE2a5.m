% BE 2a5 - Guilherme PIFFER CHRISTO
close all
clear all
clc

%% definition des paramètres
rho = 1.225 ;
r = 15 ;
Cp = 0.44 ;
Ke = 4236 ;
J = 120.5 ;
lambda = 4.2 ;
w0 = 4.2 ;
ig0 = 36.14 ;
a = -0.125 ;
v0 = 15 ;
alpha0 = (1/2)*Cp*r*r*rho*pi ;
x0 = [v0, w0];

%% Space d'états
A = [a 0 ; (3*alpha0*v0^2)/(J*w0) (-alpha0*v0^3)/(J*w0^2)]; 
B = [0 ; -Ke/J];
E = [1 ; 0]; 
C = [0  1];
D = 0;

sys = ss(A, [B E], eye(2), D,'Statename',{'v','w'},'Inputname',{'ig','\eta_w'},'Outputname',{'v','w'})
tf_sys = tf(sys);

%% Analyse du système

poles = pole(tf_sys)
zeros = tzero(tf_sys)

figure(1)
bodemag(sys);

Ctr = ctrb(A, B)
rank(Ctr)

O = obsv(A, C)
rank(O)

% simulation en boucle ouverte

figure(2)
initial(sys, [v0,w0]);

figure(3)
step(sys);

%% observateur

V = 1 ;
W = eye(2) ;
K = lqr(A',C',W,V)' ;
erreur1 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});

V = 1 ;
W = 1000*E*E' ;
K = lqr(A',C',W,V)' ;
erreur2 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});

V = 0.001 ;
W = 1000*E*E' ;
K = lqr(A',C',W,V)' ;
erreur3 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});

V = 0.001;
W = eye(2);
K = lqr(A',C',W,V)';
erreur4 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});

figure(4) 
initial(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y',[v0,w0]) ; title ('erreur initiale des 4 erreurs');

figure(5)
bodemag(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y') ; title ('bodemag des 4 erreurs');

figure(6)
step(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y');

%% Commande par retour d'état
L = [-lambda/r 1];
sysC = ss(A,B,C,0);

Q = (L')*L;
R = 0.001;
F = lqr(sysC, Q, R);

R1 = 1;
F1 = lqr(sysC, Q, R1);

R2 = 100;
F2 = lqr(sysC, Q, R2);

syst_u = ss(A-B*F,[],-F,0) ;
syst_z = ss(A-B*F,[],L,0) ;

syst_u1 = ss(A-B*F1,[],-F1,0) ;
syst_z1 = ss(A-B*F1,[],L,0) ;

syst_u2 = ss(A-B*F2,[],-F2,0) ;
syst_z2 = ss(A-B*F2,[],L,0) ;

figure(7);

subplot(221);
initial(syst_u, 'b', syst_u1, 'r', [5; 5*lambda/r]);
title('u comparant les valeurs de R entre 0,001 et 1');
legend('syst_u', 'syst_u1');

subplot(222);
initial(syst_z, 'b', syst_z1, 'r', [5; 5*lambda/r]);
title('z comparant les valeurs de R entre 0,001 et 1');
legend('syst_z', 'syst_z1');

subplot(223);
initial(syst_u, 'b', syst_u2, 'r', [5; 5*lambda/r]);
title('u comparant les valeurs de R entre 0,001 et 100');
legend('syst_u', 'syst_u2');

subplot(224);
initial(syst_z, 'b', syst_z2, 'r', [5; 5*lambda/r]);
title('z comparant les valeurs de R entre 0,001 et 100');
legend('syst_z', 'syst_z2');

syst_RE = ss(A-B*F,[],C,0) ;
BFPoles = eig(A-B*F)

syst_u_pert = ss(A-B*F,E,-F,0) ; 
syst_z_pert = ss(A-B*F,E,L,0) ;

syst_u_pert1 = ss(A-B*F1,E,-F1,0) ; 
syst_z_pert1 = ss(A-B*F1,E,L,0) ;

figure(8) ;

subplot(211) ; 
bodemag(syst_u_pert,'b',syst_u_pert1,'r') ; 
title ('bode de u comparant les valeurs de R entre 0,001 et 1 avec pertubation') ;
legend('syst_u_pert', 'syst_u1_pert');

subplot(212) ; 
bodemag(syst_z_pert,'b',syst_z_pert1,'r') ; 
title ('bode de z comparant les valeurs de R entre 0,001 et 1 avec pertubation') ;
legend('syst_z_pert', 'syst_z1_pert');

%% Commande par retour d'état avec action integrale

Ae = [a 0 0; (3*alpha0*v0^2)/(J*w0) (-alpha0*v0^3)/(J*w0^2) 0 ; -lambda/r 1 0];
Qe = [0.0784   -0.2800 0; -0.2800    1.0000 0; 0 0 0.01];
Re = 0.027;
Fi = lqr(Ae,[B;0],Qe,Re);
Fe = Fi(1,1:2);
H = Fi(1,3);


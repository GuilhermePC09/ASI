% BE 2a5 - Guilherme PIFFER CHRISTO
close all
clear all
clc

%% paramètres

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
A = [a 0 ; (3*alpha0*v0^2)/(J*w0) (-alpha0*v0^3)/(J*w0^2)] 
B = [0 ; -Ke/J] 
E = [1 ; 0] 
C = [0  1]
D = 0
sys = ss(A, [B E], eye(2), D,'Statename',{'v','w'},'Inputname',{'ig','\eta_w'},'Outputname',{'v','w'})
tf_sys = tf(sys)
poles = pole(tf_sys)
zeros = tzero(tf_sys)
bodemag(sys)

%% observateur

V = 1 ;
W = eye(2) ;
K = lqr(A',C',W,V)' ;
erreur1 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});
initial(erreur1,[v0 w0])
figure(1) ; 
bodemag(erreur1) ;title('V=1 et W = Id')

V = 1 ;
W = 1000*E*E' ;
K = lqr(A',C',W,V)' ;
erreur2 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});
initial(erreur2,[v0 w0])
figure(2) ; 
bodemag(erreur2) ; title('V=1 et W = 1000*E*E')

V = 0.001 ;
W = 1000*E*E' ;
K = lqr(A',C',W,V)' ;
erreur3 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});
initial(erreur3,[v0 w0])
figure(3) ; 
bodemag(erreur3) ;title('V=0.001 et W = 1000*E*E')

V = 0.001 ;
W = eye(2) ;
K = lqr(A',C',W,V)' ;
erreur4 = ss ((A-K*C),[-E K],eye(2),D, 'Statename',{'v','w'},'Inputname',{'eta_w','eta_v'},'Outputname',{'erreur_v','erreur_w'});
initial(erreur4,[v0 w0])
figure(3) ; 
bodemag(erreur4) ;title('V=0.001 et W = Id')


initial(sys, [v0,w0])
step(sys)

figure(6) 
initial(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y',[v0,w0]) ; title ('erreur initiale des 4 erreurs')
figure(5)
bodemag(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y') ; title ('bodemag des 4 erreurs')

step(erreur1,'b',erreur2,'g',erreur3,'r',erreur4,'y')

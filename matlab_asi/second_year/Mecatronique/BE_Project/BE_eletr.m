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

assist = 0;
%% Modele du moteur
A = [-Rs/Ls 0 0 ; 0 -Rs/Ls -(Np*lambm)/(2*Ls) ; 0 (3*Np*lambm)/(4*Jt) 0];
B = [1/Ls 0 ; 0 1/Ls ; 0 0];
C = [1 1 0];
D = 0;

%% Simulation Simulink
% sim("BE_simu",[0 10]);
% sim("BE_simu2",[0 10]);
% sim("BE_simu3",[0 10]);
% sim("BE_simu4",[0 100]);
% sim("BE_simu5",[0 100]);

 figure(5)
s=0
sim("BE_mecatronique_4",[0 100])
subplot(411)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente nulle') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
s=0.05
sim("BE_mecatronique_4",[0 100])
subplot(412)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à 5%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
s=0.07
sim("BE_mecatronique_4",[0 100])
subplot(413)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à 7%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
s=0.10
sim("BE_mecatronique_4",[0 100])
subplot(414)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à 10%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;

s=0.07 ;
figure(6)
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
subplot(211)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à 7% aidé de 100%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
subplot(212)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à 7% aidé de 200%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;

figure(7)
s=0.07 ;
subplot(311)
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste sans aide') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(312)
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste avec aide à 100%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(313)
figure(12)
s=0.10
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('puissance mécanique avec aide à 200% et pente maximale(10%)') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;

figure(8)
s=0.07 ;
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
subplot(321)
plot(ans.Pmoteur.time,ans.Pmoteur.signals.values) ; title ('P sans aide') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(322)
plot(ans.Qmoteur.time,ans.Qmoteur.signals.values) ; title ('Q sans aide') ; xlabel('temps en secondes') ; ylabel('puissance en VAr') ;
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
subplot(323)
plot(ans.Pmoteur.time,ans.Pmoteur.signals.values) ; title ('P avec aide à 100%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(324)
plot(ans.Qmoteur.time,ans.Qmoteur.signals.values) ; title ('Q avec aide à 100%') ; xlabel('temps en secondes') ; ylabel('puissance en VAr') ;
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
subplot(325)
plot(ans.Pmoteur.time,ans.Pmoteur.signals.values) ; title ('P avec aide à 200%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(326)
plot(ans.Qmoteur.time,ans.Qmoteur.signals.values) ; title ('Q avec aide à 200%') ; xlabel('temps en secondes') ; ylabel('puissance en VAr') ;

figure(7)
s=0.07 ;
subplot(311)
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.rendement.time,ans.rendement.signals.values) ; title ('rendement sans aide') ; xlabel('temps en secondes') ;
subplot(312)
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.rendement.time,ans.rendement.signals.values) ; title ('rendement avec aide à 100%') ; xlabel('temps en secondes') ;

subplot(313)
s=0.10 ;
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.rendement.time,ans.rendement.signals.values) ; title ('rendement avec aide à 200% et pente maximale (10%)') ; xlabel('temps en secondes') ;

s = -0.07 ;
figure(10)
subplot(311)
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste sans aide') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(312)
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste avec aide à 100%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;
subplot(313)
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste avec aide à 200%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;

figure(11)
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
subplot(311)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à -7% sans aide') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
subplot(312)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à -7% aidé de 100%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
subplot(313)
plot(ans.vitesse.time,ans.vitesse.signals.values) ; title ('vitesse du cycliste avec une pente à -7% aidé de 200%') ; xlabel('temps en secondes') ; ylabel('vitesse en km/h') ;

s=0.07 ;
assist = 0 ;
sim("BE_mecatronique_4",[0 100])
subplot(321)
plot(ans.tension.time,ans.tension.signals.values) ; title ('tension sans aide') ; xlabel('temps en secondes') ; ylabel('amplitude en V') ;
subplot(322)
plot(ans.courant.time,ans.courant.signals.values) ; title ('courant sans aide') ; xlabel('temps en secondes') ; ylabel('amplitude en A') ;
assist = 1 ;
sim("BE_mecatronique_4",[0 100])
subplot(323)
plot(ans.tension.time,ans.tension.signals.values) ; title ('tension avec une aide de 100%') ; xlabel('temps en secondes') ; ylabel('amplitude en V') ;
subplot(324)
plot(ans.courant.time,ans.courant.signals.values) ; title ('courant avec une aide de 100%') ; xlabel('temps en secondes') ; ylabel('amplitude en A') ;
assist = 2 ;
sim("BE_mecatronique_4",[0 100])
subplot(325)
plot(ans.tension.time,ans.tension.signals.values) ; title ('tension avec une aide de 200%') ; xlabel('temps en secondes') ; ylabel('amplitude en V') ;
subplot(326)
plot(ans.courant.time,ans.courant.signals.values) ; title ('courant avec une aide de 200%') ; xlabel('temps en secondes') ; ylabel('amplitude en A') ;

figure(13)
sim("BE_mecatronique_4",[0 100])
plot(ans.comparaison_puissances.time,ans.comparaison_puissances.signals.values) ; title ('comparaison des puissances mécanique et du cycliste avec aide à 200%') ; xlabel('temps en secondes') ; ylabel('puissance en Watt') ;


%% BE Notée - PIFFER CHRISTO Guilherme

%% Loading data and cleaning variables
clear all;
close all;
clc;
load('sujet3a.mat');

%% Observation des caractéristiques du signal
figure(1)
plot(x); title('signal x in time') ;

figure(2)
[modx,fx] = Spectre(x,fe,1);
plot(fx,modx) ; xlabel('frequencies (Hz)') ; ylabel('amplitude') ; title('signal x in frequency') ;

figure(3)
[Modulex, phasex, Fx] = DFTVisu(x,fe,256) ;
subplot(211) ; plot(Fx,Modulex) ;  xlabel('frequencies  (Hz)') ; ylabel('amplitude') ; title('module of x') ;
subplot(212) ; plot(Fx, phasex) ;   xlabel('frequencies  (Hz)') ; ylabel('degrees') ; title('phase of x') ;

figure(4)
plot(fx, 20*log10(modx)) ; title('signal x in Decibel') ;

%% Filtering of the signal

%passe bas signal 1 

fp=20;
fc=100;
F=[fp fc];
A1=[1 0];
DEV=0.01*[1 1];
[m,f0,ao,w]=firpmord(F,A1,DEV,fe);
F1=firpm(m,f0,ao,w);

figure(5)
[Modf,Phsf,Ff]=FilterVisu(F1,1,4096,fe);% création d'un filtre passe bas
 
x1 = filter(F1,1,x);
 
figure(6)
plot(x1);
title('time low pass')

%passe haut signal 2 

fp=190;
fc=250;
fo=(fc+fp)/2;
df=fc-fp;
Dlambda=df/fe;
K=round(3.1/Dlambda);
F2=fir1(K,2*fo/fe,'high');

figure(7)
[Modf3,Phsf3,Ff3]=FilterVisu(F2,1,4096,fe);

x2= filter(F2,1,x);

figure(8)
plot(x2);
title('time high pass');

% Possible passband signaux 3

fo1=130;
fo2=180;
Deltaf=10;
lo1=fo1/fe;
lo2=fo2/fe;
DeltaFnorm1=Deltaf/fe;
M=round(3.1/DeltaFnorm1);
F3=fir1(M,2*[lo1 lo2]);

figure(9)
[Modf2,Phsf2,Ff2]=FilterVisu(F3,1,4096,fe);
x3 = filter(F3,1,x);

figure(10)
plot(x3);
title('time band pass')

%% Analyse d'une courbe de charge d'un réseau de puissance
clear all
close all
clc
%% I- Contexte et grandeur à analyser 
open('consoElq.mat')
load('consoElq.mat')
figure(1)
plot(ce);

%% II- Analyse spectrale

%% 1) Préliminaires 
N=15000;
n=0:N-1;
fe=1e4;
t=n/fe;

x1=sin(2*pi*300*t+rand*2*pi);
x2=2*sin(2*pi*500*t+rand*2*pi);
x3=3*sin(2*pi*400*t+rand*2*pi);

x=x1+x2+x3;

[Mod,Freq]=Spectre(x,fe,1);
figure(2)
plot(Freq,Mod);

%% 2) Analyse spectrale de ce
Te=1/8760; % en an 
fe=1/Te; % en cycles/an
[Mod,Freq]=Spectre(ce-mean(ce),fe,1);
figure(3)
plot(Freq,Mod); % en echelle linéaire
figure(4)
plot(Freq,20*log10(Mod)); % en deciBels

% on observe 3 fondamentales à 1( correspondant à l'année), à 52
% (correspondant aux semaines) et à 365 (correspondant à la journée).

%% III- Filtrage numérique

%   On cherche à séparer les composants  correspondant à chacuns des cycles
% déterminés ci-dessus : Année, Semaine, Jour.
%   On va donc utiliser dans un premier temps un passe bas RIF s'arretant
% avant f=52, puis un passe bande autour de 52 et avant 365 et un passe
% haut avant 365 et apres 52.

%% 1) Filtre passe bas RIF-annuel 

fp=35;
fc=52;
F=[fp fc];
A1=[1 0];
DEV=0.01*[1 1];
[m,f0,ao,w]=firpmord(F,A1,DEV,fe);
FAnn=firpm(m,f0,ao,w);
[Modf2,Phsf2,Ff2]=FiltreVisu(FAnn,1,4096,fe);% création d'un filtre passe bas

ceAnn = filter(FAnn,1,ce);

figure(5)
plot(ce);
hold on;
plot(ceAnn(1+round(m/2):end),'r');

[ModAnn,FreqAnn]=Spectre(ceAnn-mean(ceAnn),fe,1);
figure(6)
plot(Freq,Mod);
hold on;
plot(FreqAnn,ModAnn,'r');

%% 2) Filtre passe bande RIF-hebdomadaire


fo1=42;
fo2=350;
Deltaf=20;
lo1=fo1/fe;
lo2=fo2/fe;
DeltaFnorm1=Deltaf/fe;
M=round(3.1/DeltaFnorm1);
FHeb=fir1(M,2*[lo1 lo2]);
figure(7)
[Modf2,Phsf2,Ff2]=FiltreVisu(FHeb,1,4096,fe); % création d'un filtre passe bande 

ceHeb = filter(FHeb,1,ce);

figure(8)
plot(ce);
hold on;
plot(ceHeb(1+round(M/2):end),'r');

[ModHeb,FreqHeb]=Spectre(ceHeb-mean(ceHeb),fe,1);
figure(9)
plot(Freq,Mod);
hold on;
plot(FreqHeb,ModHeb,'r');
%% 3) Filtre passe haut RIF-quotidien

fp=330;
fc=365;
fo=(fc+fp)/2;
df=fc-fp;
Dlambda=df/fe;
K=round(3.1/Dlambda);
FQuo=fir1(K,2*fo/fe,'high');
figure(10)
[Modf3,Phsf3,Ff3]=FiltreVisu(FQuo,1,4096,fe);

ceQuo= filter(FQuo,1,ce);

figure(11)
plot(ce);
hold on;
plot(ceQuo(1+round(K/2):end),'r');


[ModQuo,FreqQuo]=Spectre(ceQuo-mean(ceQuo),fe,1);
figure (12)
plot(Freq,Mod);
hold on;
plot(FreqQuo,ModQuo,'r');
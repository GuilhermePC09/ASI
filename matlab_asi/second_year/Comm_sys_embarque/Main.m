%% Constantes
kc=23.5e-3;
kv=23.5e-3;
J=10.8e-7;
R=9.2;
n=132;
KDT=23.5e-3;
U0=20;
Vthets=U0/(2*pi*n);
fe=1000;


%% Representation d'etat 

A=[0 1 ; 0 -kv*kc/(R*J)];
B=[0; kc/(R*J)];
C=[Vthets 0];
D=[0];
SYS=ss(A,B,C,D);

%% RE Discrète

SYSD=c2d(SYS,1/fe);

%% Tracage caracteristiques
% Numérique vers analogique:
a=20/((2^12)-1);
volt=(-10:10);
fnd=floor((1/a)*(volt+10));
figure(1)
plot(volt,fnd)
title ("caractéristique du convertisseur ADC")
xlabel("Voltage");
ylabel("Vaaleur anaalogique")

analog=0:(2^12)-1;
fdn=a*analog-10;
figure(2)
plot(analog,fdn);
title ("caractéristique du convertisseur ACD")
xlabel("Vaaleur anaalogique");
ylabel("Voltage")

%%  SIMULINK
Kp=5;

%% Observateur
Ad = SYSD.A;
Bd = SYSD.B;
Cd = SYSD.C;
Qo = [10^4 0; 0 10^3];
Ro = 0.01;


K = dlqr(Ad',Cd',Qo,Ro)';
Sys_Obs=ss( Ad-K*Cd , [Bd K] , eye(2) , zeros(2,2));

Ao = Sys_Obs.A;
Bo = Sys_Obs.B;
Co = Sys_Obs.C;
Do = Sys_Obs.D;

%% Commande par retour d'état
Qc = 10*Cd'*Cd;
Rc = 1;


Fd = dlqr(Ad,Bd,Qc ,1);
G = inv(Cd*inv(eye(2)-Ad+Bd*Fd)*Bd);



clear all;
Ts=0.1;
Te=2.0;
U0=5;
V0=6;

k1 = 0.6;
k2 = -0.25;
tr = 20;
tau = tr/4.75;
taud = 3;
xi = 1;
E = exp(-Te/taud);
a1 = -2*exp(-Te/tau);
a2 = exp(-2*Te/tau);
b1 = k1*(1-(1+Te/tau)*exp(-Te/tau));
b2 = k1*(Te/tau -1 + exp(-Te/tau))*exp(-Te/tau);

p1 = -2*E;
p2 = E^2;
p3 = 0;
p4 = 0;

r00 = (p1+p2+1)/(b1+b2);
sp01 = -p2+r00*b2;
r01 = r00*a1; 
r02 = r00*a2;

s = tf('s');
F = k1 / (1+tau*s)^2;
sys = tf(k1, [tau^2 2*tau 1]);
pols = pole(sys);
zers = zero(sys);
fd = c2d(F,Te);

%% Bezout
% Résolution manuelle de l'équation de Bezout
ap1=a1-1;
ap2=a2-a1;
ap3=-a2;

Pdes=[1 p1 p2 p3 p4];
x=inv([1 0 0 0 0; ap1 1 b1 0 0; ap2 ap1 b2 b1 0;ap3 ap2 0 b2 b1;...
   0 ap3 0 0 b2])*Pdes';
% paramètres du correcteur
sp11=x(2); % il s'agit de s'1 du cours.
r10=x(3);
r11=x(4);
r12=x(5);

% sp11=0.4687; % il s'agit de s'1 du cours.
% r10=15.07;
% r11=-17.32;
% r12=5.013;

%% RST
% Avec compensation
% R = [r00 r01 r02];
% S = [1 (sp01-1) -sp01];
% T=R;

% Sans compensation
R = [r10 r11 r12];
S = [1 (sp11-1) -sp11];
T=r10+ r11+ r12;


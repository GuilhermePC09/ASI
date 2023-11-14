%BE2
Tau=5;
Tau1 = T/10;
Tau2 = T/20;
Te = 2;

z= tf('z',Te);
s=tf('s');
k1=0.6;
k2 = -0.25;

a1=-2*exp(-Te/Tau);
a2=exp(-2*Te/Tau);
b1=k1*(1-(1+Te/Tau)*exp(-Te/Tau));
b2=k1*(Te/T-1+exp(-Te/Tau))*exp(-Te/Tau);
A= [1  a1 a2];
B= [0 b1 b2];

z1= exp(-Te/Tau);
z2= exp(-Te/Tau);
z3= exp(-Te/Tau1);
z4= exp(-Te/Tau2);

% Définition des performances désirées 
p1=-2*z1-z3-z4;
p2=z1^2+z3*z4+2*z1*(z3+z4);
p3=(z1^2 * (-z3-z4) - 2*z1*z3*z4)*0;
p4=0*(z1^2 *z3*z4);

% Résolution manuelle de l'équation de Bezout
ap1=a1-1;
ap2=a2-a1;
ap3=-a2;

Pdes=[1 p1 p2 p3 p4];
x=inv([1 0 0 0 0; ap1 1 b1 0 0; ap2 ap1 b2 b1 0;ap3 ap2 0 b2 b1;...
   0 ap3 0 0 b2])*Pdes';
% paramètres du correcteur
sp1=x(2); % il s'agit de s'1 du cours.
r0=x(3);
r1=x(4);
r2=x(5);

R = [r0 r1 r2];
S = [1 (sp1-1) -sp1];

Kz=tf(R,S,Te);
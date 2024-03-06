%%
% Définition des paramètres du modèle 
E = exp(-Te/tau);
a1 = -2*E;
a2 = E^2;
b1 = k1*(Te/tau -1 + E)*E;
b2 = k1*(1-(1+Te/tau)*E);

%% 
% Définition des performances désirées 
p1=
p2=
p3=
p4=
%%
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
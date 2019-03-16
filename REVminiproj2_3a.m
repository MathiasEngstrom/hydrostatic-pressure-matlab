D = input('Bestäm ett djup, heltal mellan 0 och 100: ');

% andraderivatan beräknas och m.h.a den  
% beräknas diskretiseringsparametern h
h1 = 0.001;                     % I.Storlek på steg
X = 0:h1:D;                     % II.Domän
f = miniint2(X,D);              % III.Funktion
Y = diff(f)/h1;                 % IV.Förstaderivatan
Z = diff(Y)/h1;                 % V.Andraderivatan
maxbiss=max((abs(Z)));          % VI.Största absoluta andraderivatan
tol = (0.5e-4);                 % VII.Tolerans för 4 korrekta decimaler
h = sqrt((tol * 12) / (D * maxbiss));  % VIII.Beräknad steglängd för beräkning av integralen

%integralen beräknas
y = linspace( 0 , D , D / h);   % I. Antal punkter, från djupet 0-D, med steg h
values = miniint2(y , D);       % II. Diskretisering av funktionen
I = trapz(y , values);          % III. Beräkning av integralen
disp(I)
D = input('Best�m ett djup, heltal mellan 0 och 100: ');

% andraderivatan ber�knas och m.h.a den  
% ber�knas diskretiseringsparametern h
h1 = 0.001;                     % I.Storlek p� steg
X = 0:h1:D;                     % II.Dom�n
f = miniint2(X,D);              % III.Funktion
Y = diff(f)/h1;                 % IV.F�rstaderivatan
Z = diff(Y)/h1;                 % V.Andraderivatan
maxbiss=max((abs(Z)));          % VI.St�rsta absoluta andraderivatan
tol = (0.5e-4);                 % VII.Tolerans f�r 4 korrekta decimaler
h = sqrt((tol * 12) / (D * maxbiss));  % VIII.Ber�knad stegl�ngd f�r ber�kning av integralen

%integralen ber�knas
y = linspace( 0 , D , D / h);   % I. Antal punkter, fr�n djupet 0-D, med steg h
values = miniint2(y , D);       % II. Diskretisering av funktionen
I = trapz(y , values);          % III. Ber�kning av integralen
disp(I)
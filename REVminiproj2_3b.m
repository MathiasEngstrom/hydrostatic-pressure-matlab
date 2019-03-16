clear all
clc
N=[]; %Lagringsvektor f�r ber�knade integraler
H=[];  %Lagringsvektor f�r ber�knade v�rden p� h
d=[];   %Lagringsvektor f�r v�rden p� D
F=[];    %Lagringsvektor f�r v�rden p� feluppskattningen

for D=10:100 %Ber�knar f�r vattenniv�, 10-100fot
    
    % 1. Andraderivatan ber�knas och m.h.a den 
     % ber�knas diskretiseringsparametern h

    h1 = 0.001;               % I.Storlek p� steg
    X = 0:h1:D;                % II.Dom�n
    f = miniint2(X,D);          % III.Funktion
    Y = diff(f)/h1;              % IV.F�rstaderivatan
    Z = diff(Y)/h1;               % V.Andraderivatan
    maxbiss=max((abs(Z)));         % VI.St�rsta absoluta andraderivatan
    tol=(0.5e-4);                   % VII.Tolerans f�r 4 korrekta decimaler
    h=sqrt((tol*12)/(D.*maxbiss));   % VIII.Ber�knad stegl�ngd f�r ber�kning av integralen
    
    % 2. Ber�kning av integralen (det hydrostatiska trycket)
    
    y=linspace(0,D,D/h);          % I. Antal punkter, fr�n djupet 0-D, med steg h
    values=miniint2(y,D);          % II. Diskretisering av funktionen
    I=trapz(y,values);              % III. Ber�kning av integralen
    
    % 3. Ber�kning av integralen med h*2 f�r feluppskattning
    
    yfel=linspace(0,D,D/(h*2));      % I. Antal punkter, fr�n djupet 0-D, med halva stegl�ngden
    valuesfel=miniint2(yfel,D);       % II. Diskretisering av funktionen
    Ifel=trapz(yfel,valuesfel);        % III. Ber�kning av integralen
    felet=(I-Ifel)/3;                   % IV. Uppskattat fel m.h.a tredjedelsregeln
    
    N=[N;I];  % De ber�knade integralerna fr�n steg 2, f�r varje v�rde p� D.
    H=[H;h];   % De ber�knade v�rdena p� stegl�ngden h fr�n steg 1, f�r varje v�rde p� D
    d=[d;D];    % Alla v�rden p� D
    F=[F;felet]; % De ber�knade felen fr�n steg 3, f�r varje v�rde p� D
end
plot1=subplot(3,1,1),plot(d,N,'r');  % Plottar hydrostatiska trycket(I) mot vattenniv�n D
plot2=subplot(3,1,2),plot(d,H,'k');   % Plottar stegl�ngden h mot vattenniv�n D
plot3=subplot(3,1,3),plot(d,F,'g');    % Plottar ber�knade felet mot vattenn�v�n D

% Namngivning p� axlarna i plottarna

ylabel(plot1,'Hydrostatiskt tryck')
xlabel(plot1,'Vattenniv� (fot)')
ylabel(plot2,'Stegl�ngd h')
xlabel(plot2,'Vattenniv� (fot)')
ylabel(plot3,{'Uppskattat fel med';'tredjedelsmetoden'})
xlabel(plot3,'Vattenniv� (fot)')
title(plot1,'Hydrostatiskt tryck mot vattenniv�')
title(plot2,'Stegl�ngd mot vattenniv�')
title(plot3,'Uppskattat fel mot vattenniv�')
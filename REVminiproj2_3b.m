clear all
clc
N=[]; %Lagringsvektor för beräknade integraler
H=[];  %Lagringsvektor för beräknade värden på h
d=[];   %Lagringsvektor för värden på D
F=[];    %Lagringsvektor för värden på feluppskattningen

for D=10:100 %Beräknar för vattennivå, 10-100fot
    
    % 1. Andraderivatan beräknas och m.h.a den 
     % beräknas diskretiseringsparametern h

    h1 = 0.001;               % I.Storlek på steg
    X = 0:h1:D;                % II.Domän
    f = miniint2(X,D);          % III.Funktion
    Y = diff(f)/h1;              % IV.Förstaderivatan
    Z = diff(Y)/h1;               % V.Andraderivatan
    maxbiss=max((abs(Z)));         % VI.Största absoluta andraderivatan
    tol=(0.5e-4);                   % VII.Tolerans för 4 korrekta decimaler
    h=sqrt((tol*12)/(D.*maxbiss));   % VIII.Beräknad steglängd för beräkning av integralen
    
    % 2. Beräkning av integralen (det hydrostatiska trycket)
    
    y=linspace(0,D,D/h);          % I. Antal punkter, från djupet 0-D, med steg h
    values=miniint2(y,D);          % II. Diskretisering av funktionen
    I=trapz(y,values);              % III. Beräkning av integralen
    
    % 3. Beräkning av integralen med h*2 för feluppskattning
    
    yfel=linspace(0,D,D/(h*2));      % I. Antal punkter, från djupet 0-D, med halva steglängden
    valuesfel=miniint2(yfel,D);       % II. Diskretisering av funktionen
    Ifel=trapz(yfel,valuesfel);        % III. Beräkning av integralen
    felet=(I-Ifel)/3;                   % IV. Uppskattat fel m.h.a tredjedelsregeln
    
    N=[N;I];  % De beräknade integralerna från steg 2, för varje värde på D.
    H=[H;h];   % De beräknade värdena på steglängden h från steg 1, för varje värde på D
    d=[d;D];    % Alla värden på D
    F=[F;felet]; % De beräknade felen från steg 3, för varje värde på D
end
plot1=subplot(3,1,1),plot(d,N,'r');  % Plottar hydrostatiska trycket(I) mot vattennivån D
plot2=subplot(3,1,2),plot(d,H,'k');   % Plottar steglängden h mot vattennivån D
plot3=subplot(3,1,3),plot(d,F,'g');    % Plottar beräknade felet mot vattennåvån D

% Namngivning på axlarna i plottarna

ylabel(plot1,'Hydrostatiskt tryck')
xlabel(plot1,'Vattennivå (fot)')
ylabel(plot2,'Steglängd h')
xlabel(plot2,'Vattennivå (fot)')
ylabel(plot3,{'Uppskattat fel med';'tredjedelsmetoden'})
xlabel(plot3,'Vattennivå (fot)')
title(plot1,'Hydrostatiskt tryck mot vattennivå')
title(plot2,'Steglängd mot vattennivå')
title(plot3,'Uppskattat fel mot vattennivå')
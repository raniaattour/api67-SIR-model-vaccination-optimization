function dydt = f(t, y, a)
    dydt = -a*y;
endfunction

t = linspace(0, 5, 1000);
y0 = 1;
a = 1;
[t, y, info] = cvode(f, t, y0, sensPar = a);
clf
plot(t,y, info.s)
//plot(t, -t.*exp(-a*t), 'r') 
//le solveur est appelé une seule fois et une seule équation (celle de la sensibilité) est ajoutée
//sensibilité est négative : quand on augment la valeur dea la solution diminue partout (logique car plus on augment a plus l'exponentielle avec -a décroit) MAIS il existe une valeur de t que l'on ne connait pas pour laquelle la sensibilité est minimale 

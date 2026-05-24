function dydt = f(t, y, p)
    dydt = -y/(1+p(2)*y);
endfunction

//pour notebook : 
load data0.sod //ATTENTION  il faut que le fichier soit dans le meme dossier que le fichier du notabook 

p = [2;1]
t = linspace(0, 10, 1000);

y0 = p(1);

[t, y, info] = cvode(f, t, y0, sensPar = p, yS0 = [1 0]);
clf
//plot(t, y, tobs, yobs, 'o');

plot(t, squeeze(info.s(1,1,:)), t, squeeze(info.s(1,2,:)));
legend("$\partial y/\partial p_1$", "$\partial y/\partial p_2$")


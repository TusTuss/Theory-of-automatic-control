sys = ss(tf(100,[1 2 100])) ;
polo = 10*real(pole(sys)) + imag(pole(sys))/10* 1i ;
polc = 5*real(pole(sys)) + imag(pole(sys))/5* 1i ;
L = place(sys.a',sys.c',polo).';
K = place(sys.a,sys.b,polc);
est = estim(sys,L,1,1) ;
rsys = reg(sys,K,L) ;
t = 0:0.05:4 ;
[y, t, x] = step(sys, t) ; 
xo0 = [0.5; -0.4];
u = ones(length(t), 1);
U = [u, y];
[yo,to,xo] = lsim(est,U,t, xo0) ;
xc0 = [0; 0] ;
[yc,tc,xc] = lsim(rsys,u,t,xc0) ;
subplot (221)
plot(t,x(:,1),'b-',t,xo(:,1),'r.',t,xc(:,1),'g--')
legend ('x1','x1o','x1c')
title('State x1 comparision')
subplot (223)
plot(t,x(:,2),'b-',t,xo(:,2),'r.',t,yc(:,1),'g--')
legend ('x2','x2o','x2c')
title('State x2 Comparision')
subplot (122)
plot(t,y(:,1),'b-',t,yo(:,1),'r.',t,yc(:,1),'g--')
legend ('y','yo','yc')
title('Output Comparision')
sgtitle('Control System Responses')
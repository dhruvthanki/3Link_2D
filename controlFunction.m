function cf = controlFunction(t,x,Fex)
m = 5;
M_h = 15;
M_t = 10;
r = 1;
l = 0.5;
g = 9.8;
alpha=0.9;
epsilon=0.1;
xd = pi/6;
q_dot = [x(4); x(5); x(6)];

D = [   r^2*((5*m)/4 + M_h + M_t),      -(m*r^2*cos(x(1) - x(2)))/2,        l*M_t*r*cos(x(1) - x(3));
        -(m*r^2*cos(x(1) - x(2)))/2,    (m*r^2)/4,                          0;
        l*M_t*r*cos(x(1) - x(3)),       0,                                  l^2*M_t];
 
C = [   0,                                  -(x(5)*m*r^2*sin(x(1) - x(2)))/2,       x(6)*l*M_t*r*sin(x(1) - x(3));
        (x(4)*m*r^2*sin(x(1) - x(2)))/2,    0,                                      0;
        -x(4)*l*M_t*r*sin(x(1) - x(3)),     0,                                      0];

G = [ -(g*r*sin(x(1))*(3*m + 2*M_h + 2*M_t))/2;
      (g*m*r*sin(x(2)))/2;
      -g*l*M_t*sin(x(3))];
  
B = [-1 0; 0 -1; 1 1];


f_x = [q_dot; (D^-1)*(-C*q_dot - G)];
g_x = [zeros(3,2); (D^-1)*B];

h = [x(3) - xd; x(1) + x(2)];

dh_dx = [0 0 1 0 0 0; 1 1 0 0 0 0];
Lf_h = dh_dx*f_x;
dLf_h_dx = [0 0 0 0 0 1; 0 0 0 1 1 0];
Lf2_h = dLf_h_dx*f_x;
LgLf_h = dLf_h_dx*g_x;

J = [r*cos(x(1)), -r*cos(x(2)), 0, 1, 0, 0;
    -r*sin(x(1)), r*sin(x(2)), 0, 0, 1, 0];
F_ex = (J')*Fex;
Lfh_Fex = dLf_h_dx*F_ex;

v = Psi(h,Lf_h,alpha,epsilon);

u = (LgLf_h^-1)*(v - Lf2_h - Lfh_Fex);

cf = f_x + g_x*u;
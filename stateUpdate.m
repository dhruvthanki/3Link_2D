function y = stateUpdate(x)
m = 5;
Mh = 15;
Mt = 10;
r = 1;
l = 0.5;

De = [ ((5/4)*m + Mh + Mt)*r^2           -(1/2)*m*(r^2)*cos(x(1) - x(2))     Mt*r*l*cos(x(1) - x(3))        ((3/2)*m + Mh + Mt)*r*cos(x(1))       -((3/2)*m + Mh + Mt)*r*sin(x(1))
        -(1/2)*m*(r^2)*cos(x(1) - x(2))     (1/4)*m*r^2                         0                               -(1/2)*m*r*cos(x(2))                    (1/2)*m*r*sin(x(2))
        Mt*r*l*cos(x(1) - x(3))            0                                   Mt*l^2                         Mt*l*cos(x(3))                         -Mt*l*sin(x(3))
        ((3/2)*m + Mh + Mt)*r*cos(x(1))   -(1/2)*m*r*cos(x(2))                Mt*l*cos(x(3))                 2*m + Mh + Mt                         0
        -((3/2)*m + Mh + Mt)*r*sin(x(1))  (1/2)*m*r*sin(x(2))                 -Mt*l*sin(x(3))                0                                       2*m + Mh + Mt];
    
E = [r*cos(x(1)) -r*cos(x(2)) 0 1 0; -r*sin(x(1)) r*sin(x(2)) 0 0 1];
M = [De, -E'; E zeros(2,2)];
qd = [x(4) x(5) x(6) 0 0]';
x_n = M\([De*qd; zeros(2,1)]);
y  = [x(2) x(1) x(3) x_n(2) x_n(1) x_n(3)]';
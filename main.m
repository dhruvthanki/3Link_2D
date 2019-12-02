clear;
clc;
ts = 0;
tf = 20;
Fext=[0 0]';
X0(:,1)=[pi/8; -pi/8; pi/6; 1.6; -1.6; 0];
yout = [;];
tout = [];
i = 2;
options = odeset('Events',@impactFunction);

while i <= 5
    if tf-ts < 0.01
        break;
    end
    X0(:,i) = stateUpdate(X0(:,i-1));
    [t,y,t0,y0] = ode45(@(t,x) controlFunction(t,x,Fext),[ts:0.01:tf],X0(:,i),options);
    X0(:,i)= y0';
    n = length(t);
    ts = t(n);
    yout = [yout; y];
    tout = [tout; t];
    i = i + 1;
end

figure
plot(tout,yout(:,1)*180/pi,'LineWidth',2)
ylabel('\theta_1(degrees)','FontSize',16)
xlabel('t(sec)','FontSize',16)
grid on

figure
plot(tout,yout(:,2)*180/pi,'LineWidth',2)
ylabel('\theta_2(degrees)','FontSize',16)
xlabel('t(sec)','FontSize',16)
grid on

figure
plot(tout,yout(:,3)*180/pi,'LineWidth',2)
ylabel('\theta_3(degrees)','FontSize',16)
xlabel('t(sec)','FontSize',16)
grid on

figure
plot3(yout(:,1),yout(:,4),yout(:,6));
xlabel('Theta1');
ylabel('Omega1');
zlabel('Omega3');
grid on
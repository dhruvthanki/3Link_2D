function [value,isterminal,direction] = impactFunction(t,y)  
value = y(1) - pi/8;     % detect height = 0
isterminal = 1;   % stop the integration
direction = 0;   % negative direction
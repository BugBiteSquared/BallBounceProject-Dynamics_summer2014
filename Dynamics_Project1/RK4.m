%Author: Brian Anthony Sheng

% RK4 function performs both a numerical single and double integration on acceleration
% to find velocity and position based on acceleration, previous position, and previous
% velocity.

% accel_func is a function handle that holds the acceleration function for the ball.

function [new_x, new_vel] = RK4(x_prev, v_prev, accel_func, time_step)

	v1 = v_prev;                    %corresponds to k1 for finding position
	a1 = accel_func(v1)*time_step;  %corresponds to k1 for finding velocity

	v2 = v_prev + 0.5*a1*time_step; %corresponds to k2 for finding position
	a2 = accel_func(v2)*time_step;  %corresponds to k2 for finding velocity

	v3 = v_prev + 0.5*a2*time_step; %corresponds to k3 for finding position
	a3 = accel_func(v3)*time_step;  %corresponds to k3 for finding velocity
	

	v4 = v_prev + a3*time_step;     %corresponds to k4 for finding position
	a4 = accel_func(v3)*time_step;  %corresponds to k4 for finding velocity

	new_x = x_prev + time_step*(v1 + 2*v2 + 2*v3 + v4)/6;
	new_vel = v_prev + (a1 + 2*a2 + 2*a3 +a4)/6;

end

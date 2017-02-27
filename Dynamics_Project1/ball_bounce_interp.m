%Author: Brian Anthony Sheng

% ball_bounce_interp function is called when the ball's y position goes below zero.
% It handles "bouncing" the ball based on its velocity on impact (calculated by linear interpolation)
% and its coefficient restitution "e".

% accel_func1 is an acceleration function handle that contains the acceleration function for postive y-velocity case.

function [x_new,v_new] = ball_bounce_interp(x_prev, x_curr, v_prev, v_curr, accel_func1, time_step, e)

    %Computes time step from impact to current index using linear
    %interpolation
    dt2 = time_step/(x_prev- x_curr)*(-x_curr);

	x_hit = 0;  %Sets "y" position = 0 at impact
    
    %Computes velocity at impact using linear interpolation
	v_hit = v_prev + (v_curr-v_prev)/(x_prev-x_curr)*(-x_curr);
    
	v_hit = -v_hit*e; %Computes velocity after imapct using restitution coeff

    %RK4 step from impact to current index using calculated time_step
	[x_new, v_new] = RK4(x_hit, v_hit, accel_func1, dt2);

end

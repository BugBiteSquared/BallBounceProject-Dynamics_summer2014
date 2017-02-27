%Author: Brian Anthony Sheng

% Modelling Script for Ball
% Populates fields in a ball structure with given values.
% Calls the launch_ball function and plots relevant results.

g = 9.81;           %gravity (m/s^2)
mass = 0.0027;      %ball mass (kg)
e = 0.8;            %coefficient of restitution (unitless)
time_step = 0.0001; %time_step (seconds)

k = 0.000359;                   %Drag Coefficient (unitless)
initial_displacement = 0.01;    %Initial Spring Displacement (m)
k_stiffness = 167.71;           %Spring Stiffness (N/m)
initial_height = 0.635;%0.635;   %Initial Ball Height (m)

%Currently doesn't do anything
box_height = 0.2;   %(m)
box_width = 0.3;    %(m)
box_position = 2;   %(m)

accel_funcx1 = @(v)(-k*v^2);    %x acceleration function assuming vx >= 0 
accel_funcx2 = @(v)(k*v^2);     %x acceleration function assuming vx < 0
accel_funcy1 = @(v)(-g-k*v^2);  %y acceleration function assuming vy >= 0
accel_funcy2 = @(v)(-g+k*v^2);  %y acceleration function assuming vy <= 0

%Loads initial conditions for position and y velocity into "ball" structure fields 
ball.x(1) = 0;
ball.y(1) = initial_height;
ball.vy(1) = 0;

%Initializes x velocity, and x & y acceleration fields for "ball" structure
ball.vx(1) = 0; %ball.vx(1), ball.ax(1), ball.ay(1) will change later in script
ball.ax(1) = 0;
ball.ay(1) = 0;

%Loads acceleration functions into corresponding fields of "ball" structure
ball.accel_funcx1 = accel_funcx1;
ball.accel_funcx2 = accel_funcx2;
ball.accel_funcy1 = accel_funcy1;
ball.accel_funcy2 = accel_funcy2;

%Loads ball mass, Coeff of Restitution, and initial time into corresponding
%fields of "ball" structure
ball.m = mass;
ball.e = e;
ball.time(1) = 0;

%launch_ball function runs the simulation with the given inputs and outputs
%another "ball" struct with arrays for each of its x, y, vx, vy, ax, ay, and
%time fields.
ball = launch_ball(ball,k_stiffness, initial_displacement, time_step);

%Usage examples for "ball" struct:
%ball.x(15) gets ball position at index 15
%ball.time(15) gets time at index 15

plot(ball.x,ball.y)
title('y vs. x position')
xlabel('x (m)')
ylabel('y (m)')

figure
plot(ball.time, ball.y)
title('y position vs. time')
xlabel('time (seconds)')
ylabel('y (m)')

figure
plot(ball.time, ball.vx)
title('x velocity vs. time')
ylabel('x (m)')
xlabel('time (seconds)')

figure
plot(ball.time, ball.vy)
title('y velocity vs. time')
ylabel('y (m)')
xlabel('time (seconds)')

figure
plot(ball.time, ball.ax)
title('x acceleration vs. time')
ylabel('x acceleration (m/s^2)')
xlabel('time (seconds)')

figure
plot(ball.time, ball.ay)
title('y acceleration vs. time')
ylabel('y acceleration (m/s^2)')
xlabel('time (seconds)')

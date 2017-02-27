%Author: Brian Anthony Sheng

% Function used to run "launch" simulation on ball.
% Calls ball_bounce_interp function and RK4 function.
% Called by launch_script to generate simulation results.

% "ball" input argument is a structure with fields: x, y, vx, vy, ax, ay, m, etc.

function ball = launch_ball(ball, k_stiffness, initial_displacement, time_step)

    %Computes initial x velocity from k_stiffness and initial_displacement
    ball.vx(1) = sqrt(k_stiffness/ball.m)*initial_displacement;

    i = 2;              %Initializes index to start iterating from i = 2
    num_bounces = 0;    %Initializes # of bounces
    
    %Computes intial x acceleration based on sign of x velocity
    if ball.vx(1) >= 0
        
        ball.ax(1) = ball.accel_funcx1(ball.vx(1));
        
    else
        
        ball.ax(1) = ball.accel_funcx2(ball.vx(1));
        
    end
    
    %Computes intial y acceleration based on sign of y velocity
    if ball.vy(1) >= 0
        
        ball.ay(1) = ball.accel_funcy1(ball.vy(1));
        
    else
        
        ball.ay(1) = ball.accel_funcy2(ball.vy(1));
        
    end

    while num_bounces < 2

        %Picks appropriate x acceleration function based on sign of x velocity
        if ball.vx(i-1) >= 0

            accel_funcx = ball.accel_funcx1;
        else

            accel_funcx = ball.accel_funcx2;

        end

        %Picks appropriate y acceleration function based on sign of y velocity
        if ball.vy(i-1) >= 0

            accel_funcy = ball.accel_funcy1;

        else

            accel_funcy = ball.accel_funcy2;

        end

        %Computes current x and y velocity and position using RK4 and
        %increments time array
        [ball.x(i),ball.vx(i)] = RK4(ball.x(i-1), ball.vx(i-1), accel_funcx, time_step);
        [ball.y(i),ball.vy(i)] = RK4(ball.y(i-1), ball.vy(i-1), accel_funcy, time_step);
        ball.time(i) = ball.time(i-1) + time_step;

        %Checks if ball has passed through or hit the floor, and either
        %calls the bounce function or handles the ball bounce manually.
        if ball.y(i) <= 0

            if ball.y(i) < 0

                [ball.y(i),ball.vy(i)] = ball_bounce_interp(ball.y(i-1), ball.y(i), ball.vy(i-1), ball.vy(i), ball.accel_funcy1, time_step, ball.e);
                num_bounces = num_bounces + 1;
                
            else
                
                ball.vy(i) = -ball.vy(i)*e;

            end

        end
        
        %Computes current x and y acceleration
        if ball.vx(i) >= 0
            ball.ax(i) = ball.accel_funcx1(ball.vx(i));
        else
            ball.ax(i) = ball.accel_funcx2(ball.vx(i)); 
        end
        
        if ball.vy(i) >= 0
            ball.ay(i) = ball.accel_funcy1(ball.vy(i));
        else
            ball.ay(i) = ball.accel_funcy2(ball.vy(i)); 
        end

        i = i + 1; %Index incrementation

    end



end

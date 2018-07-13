function plot_data(data, const)
    %{
     Plots the current state of the simulation.

     @param    data     A struct with fields u, phi, and ut each
                        containing the state of their respective functions
                        at a particular time-step.
     @param    const    A struct with the fields hy and Ly.
    %}
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    
    extended_phi = [0; data.phi];
    rod_position = data.u + y';
    
    figure(1);
    plot(y, rod_position, 'b', y, data.ut, 'g', y, extended_phi, 'r');
    
    figure(2);
    plot(x, data.w, 'b', x, data.wt, 'g', x, data.theta, 'r', x, data.theta_t, 'y');
    
%     disp('---------')
%     disp('w')
%     disp(data.w(end))
    disp('u')
    disp(data.u(end))
    disp('sigma_dt')
    disp(data.sigma_dt)
    
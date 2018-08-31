function config = get_config(num_nodes, ht, num_steps)
    %{
     Creates a struct containing fields for various configuration options.
     Edit this file to adjust coefficents and inital data used in the
     simulation, as well as output options.

     @param    num_nodes       the number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.

     @return    config    A struct containing the fields const, initial,
                          plot_fn, and log_fns.
                         
    %}
    %%% Simulation options
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Change only two data
    %kappa_th = 200 beta=100
    %kappa_th = 40 beta=100
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %kappa_th = 10 beta=-100 -> it is interesting but won't be used
    % beta gives negative energy then there are so many frequencies(beta=-1.4)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %run_simulation(500,0.00001,1000)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Constants (to be consumed by get_constants.m)
    config.const = struct('alpha_d', 10^-5, 'alpha_b', 0, 'eta_d', 1, ...
        'kappa_th', 200, 'zeta_d', 100, 'Ed', 1, 'Eb', 1, 'G', 1, ...
        'beta', 100, 'rho', 1, 'gap', 0.002, 'Ly', 1, ...
        'num_nodes', num_nodes, 'ht', ht, 'num_steps', num_steps, ...
        'T', num_steps*ht);
    % Initial data (to be consumed by get_initial_data.m)
    config.initial = struct('u', @(y) -0.011, 'ut', @(y) 0, 'w', @(x) -0.011*x, ...
        'wt', @(x) 0, 'theta', @(x) 0, 'theta_t', @(x) 0.0*x);
    
    
    %%% Output options
    
    % Set to true if you want to progress the simulation manually
    config.wait_for_input = false; 
    
    % Set plot function
    config.prep_plot_fn = @prep_animation;
    config.plot_fn = @update_animation;
    
    % Set save function
    config.prep_save_output_fn = @prep_save_if_collision;
    config.save_output_fn = @save_if_collision;

    % Set log functions
    log_msgs = {'sigma_dt', ...
                'Un', ...
                'sigma_db'};
    log_data = {@(data, const) data.sigma_dt, ...
                @(data, const) data.u(end), ...
                @(data, const) data.sigma_db};
    config.log_fns = containers.Map(log_msgs, log_data);

    % For performance testing uncomment the following to suppress all output 
%     config.wait_for_input = false;
    config.log_fns = false;
%     config.prep_plot_fn = @(x, y) NaN;
%     config.plot_fn = @(x, y, z) NaN;
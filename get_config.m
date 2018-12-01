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
    % Change obly two data
    % beta=2500, beta=25
    % kappa_th = 0.85
    % kappa_th = 85
    %run_simulation(1000,0.0001,10000)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Constants (to be consumed by get_constants.m)
    config.const = struct('alpha_d', 10^-6, 'alpha_b', 0, 'eta_d', 10, ...
                          'kappa_th', 85, 'zeta_d', 1, 'Ed', 500, 'Eb', 150, 'G', 1000, ...
                          'beta', 2500, 'rho', 1, 'gap', 0.002, 'Ly', 1, 'num_steps', num_steps, ...
                          'num_nodes', num_nodes, 'ht', ht, 'T', num_steps*ht);
                           % Initial data (to be consumed by get_initial_data.m)
    config.initial = struct('u', @(y) -0.001, 'ut', @(y) 0, 'w', @(x) -0.001*x, ...
                            'wt', @(x) 0, 'theta', @(x) 0, 'theta_t', @(x) 0.0*x);

    %%% Output options

    % Set to true if you want to progress the simulation manually
    config.wait_for_input = false;

    % Set plot function
    config.prep_plot_fn = @prep_transient;
    config.plot_fn = @update_transient;

    % Set save function
    config.prep_save_output_fn = @prep_save_figs;
    config.save_output_fn = @save_figs;

    % Set log functions
    log_msgs = {'sigma_dt', ...
                'Un', ...
                'sigma_db', ...
                'contact'};
    log_data = {@(data, const) data.sigma_dt, ...
                @(data, const) data.u(end), ...
                @(data, const) data.sigma_db, ...
                @(data, const) is_in_contact(data, const)};
    config.log_fns = containers.Map(log_msgs, log_data);

    % For performance testing uncomment the following to suppress all output
%     config.wait_for_input = false;
    config.log_fns = false;
    config.prep_plot_fn = @(x, y, z) NaN;
    config.plot_fn = @(x, y, z) NaN;
    %% config.prep_save_output_fn = @(x, y) NaN;
    %% config.save_output_fn = @(w, x, y, z) NaN;
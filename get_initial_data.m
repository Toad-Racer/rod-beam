function data = get_initial_data(config_data, const)
    %{
     Creates a struct containing fields for all initial data. This struct  
     can be passed to any function in this project with a parameter name
     ending in 'data'.

     @param    config          A struct with a 'initial' field containing
                               all configurable initial data. See
                               get_config.m for a full list.
     @param    const           A struct with fields for each constant relvant
                               to the simulation. See get_constants.m for a full
                               list.

     @return    data    A struct containing both the primary and the derived
                        data (u, phi, theta, w, ut, theta_t, wt, f1, f2, f3, 
                        f4, r, sigma_dt) for the initial time-step.
    %}
    % Domains for primary functions
    y_u = 0:const.hy:const.Ly;
    y_phi = y_u(2:end); % The phi vector is one shorter than the u vector
    x = const.hx:const.hx:1;

    % Set initial functions (except phi, it is defined further down)
    data = struct('u', arrayfun(config_data.u, y_u'), ...
        'ut', arrayfun(config_data.ut, y_u'), ...
        'w', arrayfun(config_data.w, x'), 'wt', arrayfun(config_data.wt, x'),  ...
        'theta', arrayfun(config_data.theta, x'), ...
        'theta_t', arrayfun(config_data.theta_t, x'));
        
    % Misc
    data.r = r(data, const);
    data.phi = (exp(-K(data.r)/const.kappa_th.*(y_phi-1)) ...
        - exp(K(data.r)/const.kappa_th).*cos(pi/2*y_phi).^2)';
    data = merge_structs(data, loading_vectors(data, const));
    data.rod_matrix = current_rod_matrix(data, const);
    
    % Assume no contact on first time-step
    data.sigma_dt = 0;
    data.sigma_db = NaN; % Don't know yet
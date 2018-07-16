function data = get_initial_data(config, const)
    %{
     Creates a struct containing fields for all initial data. This struct  
     can be passed to any function in this project with a parameter called 
     'primary_data', 'current_data', or 'prev_data'.

     @param    const           A struct with fields for each constant relvant
                               to the simulation. See set_constant.m for a full
                               list.

     @return    data    A struct containing both the primary and the derived
                        data (u, phi, theta, w, ut, theta_t, wt, f1, f2, f3, 
                        f4, r) for the initial time-step. Can be passed to any 
                        function in this project with a 'primary_data', 
                        'current_data', or 'prev_data' parameter.
    %}
    y_u = 0:const.hy:const.Ly;
    y_phi = y_u(2:end);
    x = const.hx:const.hx:1;

    data = struct('u', arrayfun(config.initial.u, y_u'), ...
        'ut', arrayfun(config.initial.ut, y_u'), ...
        'w', arrayfun(config.initial.w, x'), 'wt', arrayfun(config.initial.wt, x'),  ...
        'theta', arrayfun(config.initial.theta, x'), ...
        'theta_t', arrayfun(config.initial.theta_t, x'), 'sigma_dt', 0);
        
    data.r = r(data, const);
    data.phi = (exp(-K(data.r)/const.kappa_th.*(y_phi-1)) ...
        - exp(K(data.r)/const.kappa_th).*cos(pi/2*y_phi).^2)';
    data = merge_structs(data, loading_vectors(data, const));
    data.rod_matrix = current_rod_matrix(data, const);
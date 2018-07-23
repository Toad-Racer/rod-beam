function data = add_derived_data(primary_data, prev_data, const)
    %{
     Adds derived data to a given struct containing the primary data 
     for the current time step. The resulting struc can be passed to any 
     function in this project with a parameter name ending in 'data'.

     @param    primary_data    A struct with fields for each of the system's
                               primary functions (u, phi, theta, and w) and
                               stresses (sigma_db, sigma_dt) at the current 
                               time step.
     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step.
     @param    const           A struct with fields for each constant relvant
                               to the simulation. See get_constant.m.

     @return    data    A struct containing both the primary and the derived
                        data (u, phi, theta, w, ut, theta_t, wt, f1, f2, f3, 
                        f4, r, sigma_db, and sigma_dt) for the current
                        time-step.
    %}
    data = primary_data;
    
    % Velocity functions
    data.ut = 1/const.ht*(primary_data.u - prev_data.u);
    data.theta_t = 1/const.ht*(primary_data.theta - prev_data.theta);
    data.wt = 1/const.ht*(primary_data.w - prev_data.w);
    
    % Misc
    data.r = r(data, const);
    data.energy = current_energy(data, const);
    data = merge_structs(data, loading_vectors(data, const));
    data.rod_matrix = current_rod_matrix(data, const);
    
    
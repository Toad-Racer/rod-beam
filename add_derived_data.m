function data = add_derived_data(primary_data, prev_data, const)
    %{
     Adds derived data (ut, f, r, rod_matrix, sigma_db, and sigma_dt)
     to a given struct containing the primary data (u and phi) for the 
     current time step. The resulting struct can be passed to any function
     in this project with a 'primary_data', 'prev_data', or 'current_data'
     parameter.

     @param    primary_data    A struct with fields for each of the system's
                               primary functions (u, phi, theta, and w) 
                               containing their values for the current time step.
     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step.
     @param    const           A struct with fields for each constant relvant
                               to the simulation. See set_constant.m for a full
                               list.
     @return    data    A struct containing both the primary and the derived
                        data (u, phi, theta, w, ut, theta_t, wt, f1, f2, f3, f4,
                        r, sigma_db, and sigma_dt) for the current
                        time-step. Can be passed to any function in this 
                        project with a 'primary_data', 'current_data', or 
                        'prev_data' parameter.
    %}
    data = primary_data;
    
    data.ut = 1/const.ht*(primary_data.u - prev_data.u);
    data.theta_t = 1/const.ht*(primary_data.theta - prev_data.theta);
    data.wt = 1/const.ht*(primary_data.w - prev_data.w);
    
    data = merge_structs(data, loading_vectors(data, const));
    data.r = r(data, const);
    data.rod_matrix = current_rod_matrix(data, const);
    
    
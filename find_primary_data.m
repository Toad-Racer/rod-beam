function primary_data = find_primary_data(prev_data, const)
    %{
     Approximates the system's primary functions and stresses at the
     current time step by solving the nonlinear reccurence
     relation with all constraints applied. 

     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with all constants relevant to the 
                               simulation. See get_constants.m for a full
                               list.

     @return    primary_data    A struct containing the system's primary data 
                                (u, phi, theta, w, sigma_db, and sigma_dt) 
                                at the current time-step. Can be passed to any
                                function in this project with a 'primary_data'
                                parameter.
    %}
    pinv = partially_invert_rod_system(prev_data, const);
    
    if prev_data.sigma_dt == 0 % If there was no contact last step
        % Initially assume there will not be contact this step
        primary_data = no_contact_data(pinv, prev_data, const);
        if ~primary_data.assumption_consistent % If there is contact
            primary_data = with_contact_data(pinv, prev_data, const);
        end
    else % If there was contact last step
        % Initially assume there will be contact this step
        primary_data = with_contact_data(pinv, prev_data, const);
        if ~primary_data.assumption_consistent % If there is no contact
            primary_data = no_contact_data(pinv, prev_data, const);
        end
    end
    
    primary_data.t = prev_data.t + const.ht;

    


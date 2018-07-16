function primary_data = find_primary_data(prev_data, const)
    %{
     Solves for the rod's primary data (u and phi) at the current time step.
     Since this simulation currently ignores contact and the beam, the 
     linear system is simply solved using mldivide. 

     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with the field num_nodes containg
                               the number of nodes on the rod's domain
                               (counting nodes at y=0 and y=Ly as well as
                               all interior nodes).
     @return    data    A struct containing the system's primary data 
                        (u, phi, theta, and w) at the current time-step.
                        Can be passed to any function in this project with
                        a primary_data parameter.
    %}
    pinv = partially_invert_rod_system(prev_data, const);
    
    if prev_data.sigma_dt == 0 % If there was no contact last step
        % Initially assume there will not be contact this step
        primary_data = no_contact_data(pinv, prev_data, const);
        if ~primary_data.valid % If there is contact
            primary_data = with_contact_data(pinv, prev_data, const);
        end
    else % If there was contact last step
        % Initially assume there will be contact this step
        primary_data = with_contact_data(pinv, prev_data, const);
        if ~primary_data.valid % If there is no contact
            primary_data = no_contact_data(pinv, prev_data, const);
        end
    end

    


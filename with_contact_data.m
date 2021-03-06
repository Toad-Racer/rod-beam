function data = with_contact_data(pinv, prev_data, const)
    %{
     Approximates the system's primary functions and stresses at the
     current time step assuming there will be contact on this time-step.
     If the assumption proves invalid then the return value will reflect
     that.

     @param    pinv            A struct representing the partially inverted
                               rod system. It contains fields f, b, and t.
                               See partially_inverted_rod_system.m for more
                               details.
     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with all constants relevant to the 
                               simulation. See get_constants.m for a full
                               list.

     @return    data    A struct containing the system's primary data 
                        (u, phi, theta, w, sigma_db, and sigma_dt) at the
                        current time-step if the contact assumption
                        proves consistent. If the assumption is inconsitent
                        then data will only contain the field 
                        'assumption_consistent' which will be set to false.
    %}
    % sym_sigma_db is a vector representing the sum sigma_db = a*Wn + b
    % where a and b are the first and second elements of the vector
    sym_sigma_db = 1/(-pinv.b(1)+pinv.t(1)/pinv.t(const.num_nodes)*pinv.b(const.num_nodes))* ... 
        [1, -pinv.f(1)-pinv.t(1)/pinv.t(const.num_nodes)*(const.gap-pinv.f(const.num_nodes))];
    beam_data = find_beam_data(prev_data, const, sym_sigma_db);
    sigma_db = sym_sigma_db*[beam_data.w(end); 1]; % Calculate numeric value of sigma_db
    sigma_dt = 1/pinv.t(const.num_nodes)*(const.gap - pinv.f(const.num_nodes) ...
        + pinv.b(const.num_nodes)*sigma_db);
    
    % Verify assumption of contact
    if sigma_dt < 0 % If there is contact
        data = beam_data;
        
        u = pinv.f - sigma_db*pinv.b + sigma_dt*pinv.t;
        data.u = u(1:const.num_nodes);
        data.phi = u(const.num_nodes+1:end);

        data.sigma_db = sigma_db;
        data.sigma_dt = sigma_dt;
        
        data.assumption_consistent = true; % Function's assumption of contact is valid
    else % If there is no contact
        data.assumption_consistent = false; % Functions's assumption of contact is invalid
    end
    
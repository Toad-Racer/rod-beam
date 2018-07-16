function data = no_contact_data(pinv, prev_data, const)
    % sym_sigma_db is a vector representing the sum sigma_db = a*Wn + b
    % where a and b are the first and second elements of the vector
    sym_sigma_db = -1/pinv.b(1)*[1, -pinv.f(1)];
    beam_data = find_beam_data(prev_data, const, sym_sigma_db);
    sigma_db = sym_sigma_db*[beam_data.w(end); 1]; % Calculate numeric value of sigma_db
    sigma_dt = 0; % Since we've assumed no contact
    u_n = pinv.f(const.num_nodes) + sigma_db*pinv.b(const.num_nodes);
    
    % Verify assumption of no contact
    if u_n < const.gap % If no contact
        u = pinv.f - sigma_db*pinv.b;
        rod_data = struct('u', u(1:const.num_nodes), ...
            'phi', u(const.num_nodes+1:end));
        
        data = merge_structs(beam_data, rod_data, ...
            struct('sigma_db', sigma_db, 'sigma_dt', sigma_dt));
        
        data.valid = true; % Function's assumption of no contact is valid
    else % If contact
        data.valid = false; % Function's assumption of no contact is invalid
    end
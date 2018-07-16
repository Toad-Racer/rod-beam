function data = with_contact_data(pinv, prev_data, const)
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
        
        data.valid = true; % Function's assumption of contact is valid
    else % If there is no contact
        data.valid = false; % Functions's assumption of contact is invalid
    end
    
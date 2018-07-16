 function beam_data = find_beam_data(prev_data, const, sigma_br)
    %{
     Approximates the values of w and theta for the current time-step using
     newton's iteration.
    
     @param    prev_data    A struct with fields for the primary and 
                            derived data of the previous time-step. See
                            add_derived_data.m for a full list of fields.
     @param    const        A struct with fields for each constant relevant
                            to the simulation. See get_constants.m for a
                            full list of fields.
     @param    sigma_br     A vector representing the equation
                            sigma_br = a*Wn + b where a and b are
                            the first 2 elements of the vector.

     @return    beam_data    A struct with fields for w and theta at the
                             current time-step.
    %}
    f = prev_data.f3;
    g = prev_data.f4;
    g(end) = g(end) + sigma_br(2); % apply the constant part of sigma_br
    I = sparse(length(g), length(g));
    I(end, end) = 1;
    
    theta = @(w) const.B33\(f-const.B34*w);
    % Nonlinear system
    F = @(w) const.B43*theta(w) + const.B44*w+N(w, const)-g ... 
        -[zeros(length(g)-1, 1); sigma_br(1)*w(end)]; % apply Wn-dependent term of sigma_br
    
    % constant term of jacobian
    C = const.jac_term - sigma_br(1)*I; % Apply sigma_br term to jacobian
    % Jacobian of F
    JF = @(w) C + 1/2*const.rho*(2*(const.Kb*w)*(const.Kb*w)' ... 
        +(w'*const.Kb*w)*const.Kb);
    
    % Approximate w
    beam_data.w = newtons_method(F, JF, prev_data.w, 10^(-6));
    % Backsubstitute to find theta
    beam_data.theta = theta(beam_data.w);
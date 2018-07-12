function value = r(current_data, const)
    %{
     Computes the value of r for the current time-step.

     @param    current_data    A struct with fields u and sigma_dt containg
                               their values at the current time step.
     @param    const           A struct with the field gap containg the
                               size the the initial gap between the
                               undisplaced top of the rod and the rigid body.
     @return    value    The value of the natural variable r at the current
                         time-step.
    %}
    current_gap = const.gap - current_data.u(end);
    if current_gap > 0 % if there is no contact
        value = current_gap;
    else % if there is contact
        % contact is not currently considered
        error('The rod is in contact with the rigid body');
        % value = current_data.sigma_dt;
    end
    
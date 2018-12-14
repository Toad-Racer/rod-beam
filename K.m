function value = K(r)
    %{
     Computes the value of K for the current time-step.

     @param    r    The scaler value of the natural variable r at the
                    current time step.

     @return    value    The value of K at the current time-step.
    %}
    %value = (1/2 + 1/pi*atan(-10^3*r)); % formula taken from previous paper
    value = 100*(1/2 + (1/pi)*atan(-10^8*r));
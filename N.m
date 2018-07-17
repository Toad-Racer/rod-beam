function value = N(w, const)
    %{
     Computes the value of Nw for a given w.

     @param    w        The vector approximation of the beam's displacement.
     @param    const    A struct with fields for each of the constants
                        relevant to the simulation. See get_constants.m 
                        for a full list.

     @return    value    The value of Nw.
    %}
    value = (const.beta + const.rho*(w'*const.Kb*w))*const.Kb;
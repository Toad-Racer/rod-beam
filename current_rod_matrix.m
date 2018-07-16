function rod_matrix = current_rod_matrix(current_data, const)
    %{
     Constructs the block matrix on the left hand side of the recurrence 
     relation defined in the manuscript for the current time step.
    
     @param    current_data    A struct with a field for the current value
                               of the natural variable 'r'.
     @param    const           A struct with fields for the matrices B11, 
                               B12, B21, and B22 as defined in the manuscript
                               (but without the time-dependent term of B22).

     @return    rod_matrix    The block matrix on the left hand side of the
                              recurrence relation for the current time step.
    %}
     % Assemble block matrix
     rod_matrix = [const.B11, const.B12; const.B21, const.B22];
     % Add time-dependent term of B22
     rod_matrix(end, end) = rod_matrix(end, end) + K(current_data.r)/2;
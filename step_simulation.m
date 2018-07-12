function next_data = step_simulation(current_data, const)
    %{
     Finds the data for the next time-step and plots it.

     @param    current_data    A struct with fields for the primary and
                               derived data of the current time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with fields for each constant relvant
                               to the rod. See set_constant.m for a full
                               list.

     @return    next_data    A struct with fields for the primary and
                             derived data of the next time-step. See
                             add_derived_data.m for a full list.
    %}
    next_data = add_derived_data(find_primary_data(current_data, const), current_data, const);
    %plot_data(next_data, const);
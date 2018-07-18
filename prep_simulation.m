function [const, initial_data, plot_fn, log_fns] = prep_simulation(num_nodes, ht)
    %{
     Creates a struct for all relevant constants (see set_constants.m for a 
     full list), a struct for all inital data (see initial_data.m for a
     full list) and gets configurable output options.

     @param    num_nodes       the number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.

     @return    const           A struct containing all relevant constants 
                                (see set_constants.m for a full list).
     @return    initial_data    A struct containing all inital data 
                                (see initial_data.m for a full list).
     @return    plot_fn         A function to be called to plot the current
                                state of the system at each time-step.
     @return    log_fns         Functions to be called to log certain bits
                                data to the matlab console at each
                                time-step.
    %}
    config = get_config(num_nodes, ht);
    const = get_constants(config);
    initial_data = get_initial_data(config, const);
    plot_state = config.prep_plot_fn(initial_data, const);
    plot_fn = @(data, const) config.plot_fn(plot_state, data, const);
    log_fns = config.log_fns;

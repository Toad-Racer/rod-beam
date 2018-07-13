function [const, initial_data, plot_fn, log_fns] = prep_simulation(num_nodes, ht)
    %{
     Creates a struct for all relevant constants (see set_constants.m for a 
     full list), a struct for all inital data (see initial_data.m for a
     full list), and plots the initial state of the simulation.

     @param    num_nodes       the number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.

     @return    const           A struct containing all relevant constants 
                                (see set_constants.m for a full list).
     @return    initial_data    A struct containing all inital data 
                                (see initial_data.m for a full list).    
    %}
    config = get_config(num_nodes, ht);
    const = set_constants(config);
    initial_data = set_initial_data(config, const);
    plot_fn = config.plot_fn;
    log_fns = config.log_fns;

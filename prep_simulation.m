function sim = prep_simulation(num_nodes, ht, num_steps)
  %{
     Creates a struct for all relevant constants (see set_constants.m for a
     full list), a struct for all inital data (see initial_data.m for a
     full list), gets configurable output options and returns them all in a
     struct.

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
                                Takes 2 arguments.
     @return    log_fns         Functions to be called to log certain bits
                                data to the matlab console at each
                                time-step.
  %}
    config = get_config(num_nodes, ht, num_steps);
    sim.const = get_constants(config.const);
    sim.data = get_initial_data(config.initial, sim.const);
    plot_state = config.prep_plot_fn(sim.data, sim.const, 'on');
    sim.plot_fn = @(data, const) config.plot_fn(plot_state, data, const);
    sim.save_state = config.prep_save_output_fn(sim.data, sim.const);

    sim.log_fns = config.log_fns;
    sim.save_output_fn = config.save_output_fn;
    sim.wait_for_input = config.wait_for_input;

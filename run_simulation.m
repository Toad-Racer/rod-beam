function run_simulation(num_nodes, ht, num_steps)
    %{
     Runs a simulation of the rod and beam.  On each time-step the
     state of the simulation will be plotted using the plot_fn specified
     get_config.m.

     @param    num_nodes       The number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.
     @param    num_steps       The numer of time-steps to simulate.
    %}
    sim = prep_simulation(num_nodes, ht, num_steps);
    output_data(sim);
    save_state = sim.save_output_fn(sim.prep_save_output_fn(), ...
         sim.data, sim.const);
    for i = 1:num_steps
        sim.data = step_simulation(sim.data, sim.const);
        output_data(sim);
        save_state = sim.save_output_fn(save_state, sim.data, sim.const);
    end

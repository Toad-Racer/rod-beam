function run_beam_simulation(num_nodes, ht, num_steps)
    sim = prep_simulation(num_nodes, ht, num_steps);
    sim.log_fns = false;
    sim.plot_fn = beam_plot_fn();
    output_data(sim);
    for i = 1:num_steps
        sim.data = add_derived_data(merge_structs(sim.data, ...
            find_beam_data(sim.data, sim.const, [0 0])), sim.data, sim.const);
        output_data(sim);
    end
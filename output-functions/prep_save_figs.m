function save_state = prep_save_figs(initial_data, const)
    import java.util.LinkedList;
    save_state.collisions = LinkedList;
    save_state.data_buffer = buffer(initial_data, 6);
    save_state.time_step = 0;
    save_state.transient_lines = prep_transient(initial_data, const, 'off');
    save_state.holistic_lines = prep_holistic(initial_data, const, 'off');
    save_state.holistic_data = struct('t', 0:const.ht:const.T, ...
                                      'sigma_dt', [initial_data.sigma_dt, zeros(1, const.num_steps)], ...
                                      'energy', [initial_data.energy, zeros(1, const.num_steps)], ...
                                      'tip', [initial_data.u(end) + 1, zeros(1, const.num_steps)]);

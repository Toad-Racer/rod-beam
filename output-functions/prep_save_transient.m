function save_state = prep_save_transient(initial_data, const)
  import java.util.LinkedList;
  save_state.collisions = LinkedList;
  save_state.sim_data = LinkedList;
  save_state.time_step = 0;
  save_state.lines = prep_transient(initial_data, const, 'off');
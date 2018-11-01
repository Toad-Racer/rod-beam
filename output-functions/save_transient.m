function new_state = save_transient(save_state, data, const)
  new_state = save_state;
  if save_state.collisions.size == 3 % If we're past the first 3 timesteps
    post_impact = ~new_state.collisions.remove() && new_state.collisions.peek();
  else
    post_impact = false;
  end

  if post_impact || save_state.time_step == 5 || save_state.time_step == const.num_steps
    figs = findobj('Type', 'figure');
    for i = 1:size(figs, 1)
      saveas(figs(i), sprintf('out/timeStep%d-%d', save_state.time_step, i), 'epsc');
    end
  end

  new_state.collisions.add(is_in_contact(data, const));
  new_state.time_step = save_state.time_step + 1;
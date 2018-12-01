function new_state = save_figs(save_state, data, const)
    new_state = save_state;
    new_state.time_step = save_state.time_step+1;
    tran_figs = save_state.transient_lines.figs;

    if new_state.collisions.size == 3 % If we're past the first 3 timesteps
        post_contact = ~new_state.collisions.get(0) && new_state.collisions.get(1);
        post_release = new_state.collisions.get(0) && ~new_state.collisions.get(1);
        new_state.collisions.pop();
    else
        post_contact = false;
        post_release = false;
    end

    if post_contact
        % before contact
        save_transient(tran_figs, new_state.transient_lines, ...
                       new_state.data_buffer.peek(), new_state.time_step-6, const);
    elseif post_release
        % after contact
        save_transient(tran_figs, new_state.transient_lines, data, new_state.time_step, const);
    end

    new_state.collisions.add(is_in_contact(data, const));
    new_state.data_buffer.push(data);
    new_state.holistic_data.sigma_dt(new_state.time_step+1) = data.sigma_dt;
    new_state.holistic_data.energy(new_state.time_step+1) = data.energy;
    new_state.holistic_data.tip(new_state.time_step+1) = data.u(end) + 1;

    if (~(new_state.time_step < const.num_steps))
        close(tran_figs);
        save_holistic(save_state.holistic_lines, new_state.holistic_data);
    end

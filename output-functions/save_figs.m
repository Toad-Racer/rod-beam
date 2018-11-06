function new_state = save_figs(save_state, data, const)
    new_state = save_state;
    new_state.time_step = save_state.time_step+1;
    tran_figs = save_state.transient_lines.figs;

    if new_state.collisions.size == 3 % If we're past the first 3 timesteps
        post_impact = ~new_state.collisions.remove() && new_state.collisions.peek();
    else
        post_impact = false;
    end

    if post_impact & new_state.first_impact
        new_state.first_impact = false;

        % before impact
        update_transient(new_state.transient_lines, new_state.data_buffer.peek(), const);
        for i = 1:size(tran_figs, 1)
            saveas(tran_figs(i), sprintf('out/timeStep%d-%d', new_state.time_step-6, i), 'epsc');
        end

        % after impact
        update_transient(new_state.transient_lines, data, const);
        for i = 1:size(tran_figs, 1)
            saveas(tran_figs(i), sprintf('out/timeStep%d-%d', new_state.time_step, i), 'epsc');
        end
    elseif new_state.time_step == ceil(const.num_steps/4)
        update_transient(new_state.transient_lines, data, const);
        for i = 1:size(tran_figs, 1)
            saveas(tran_figs(i), sprintf('out/timeStep%d-%d', new_state.time_step, i), 'epsc');
        end
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

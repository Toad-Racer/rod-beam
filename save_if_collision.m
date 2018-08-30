function new_state = save_if_collision(save_state, next_frame, data, const)
    save_state.offset = mod(save_state.offset + 1, 5);
    i = mod(save_state.offset+2, 5) + 1;
    save_state.frames(mod(i+1, 5) + 1, 1:size(next_frame, 2)) = next_frame;
    save_state.contacts(mod(i+1, 5) + 1) = is_in_contact(data, const);
    
    if size(save_state.frames, 1) == 5
        save_state.frames_full = true;
    end
    
    if save_state.frames_full
        collision = save_state.contacts(i) && ~save_state.contacts(mod(i-2,5)+1);
        if collision
            save_state.collision_num = save_state.collision_num + 1;
            save_collision(save_state.frames, i, save_state.collision_num);
        end
    end   
    
    new_state = save_state;
    
    
    
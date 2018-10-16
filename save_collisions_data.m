function save_collisions_data(output, sim)
    collisions = 0;
    i = 3;
    
    while i <= size(output.frames, 2)
        if output.contacts(i) && ~output.contacts(i-1)
            collisions = collisions + 1;
            save_collision_data(output, i, collisions);
        end
        i = i+1;
    end
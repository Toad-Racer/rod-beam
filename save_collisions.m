function save_collisions(output, sim) 
    collisions = 0;
    i = 3;
    
    while i <= size(output.frames, 2) - 2
        if output.contacts(i) && ~output.contacts(i-1)
            collisions = collisions + 1;
            save_collision(output, i, collisions);
            fprintf("collision at time t=%f", i*sim.const.ht); 
        end
        i = i+1;
    end

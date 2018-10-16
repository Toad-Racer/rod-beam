function save_collision_data(output, frame_i, collision_num)
    try 
        dlmwrite(sprintf('out/collision%d.txt', collision_num, output.data(frame_i)));
        dlmwrite(sprintf('out/pre-collision%d.txt', collision_num, output.data(frame_i-2)));
        dlmwrite(sprintf('out/post-collision%d.txt', collision_num, output.data(frame_i+2)));
    catch
        fprintf("Collision %d was not completely captured\n", collision_num);
    end
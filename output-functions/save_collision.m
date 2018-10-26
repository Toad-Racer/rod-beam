function save_collision(frames, frame_i, collision_num)
    collision_frame = frames(frame_i, :);
    pre_collision_frame = frames(mod(frame_i-3, 5)+1, :);
    post_collision_frame = frames(mod(frame_i+1, 5)+1, :);
    for i = 1:size(collision_frame, 2)
        imwrite(collision_frame(1,i).cdata, ...
            sprintf('out/collision%d-%d-%d.png', collision_num, 2, i));
        imwrite(pre_collision_frame(1,i).cdata, ...
            sprintf('out/collision%d-%d-%d.png', collision_num, 1, i));
        imwrite(post_collision_frame(1,i).cdata, ...
            sprintf('out/collision%d-%d-%d.png', collision_num, 3, i));
    end
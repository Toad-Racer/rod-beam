function mask = rod_animation_mask(const)
    mask = zeros(const.num_nodes, 1);
    spacing = int32(const.num_nodes/100);
    for i = [1:spacing:const.num_nodes-1, const.num_nodes]
        mask(i) = 1;
    end
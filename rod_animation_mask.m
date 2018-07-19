function mask = rod_animation_mask(const)
    %{
     Constructs a vector used to filter the rod's position data for animation.
     To apply the filter dot-multiply the returned vector 'mask' by the rod's 
     position vector. That will zero out all nodes except the first, the
     last, and ~98 evenly spaced in the middle.

     @param    const    A struct containing all constants relevant to the 
                        simulation. See get_constants.m for more details.

     @return    mask    A vector with 0s at each index to be filtered out
                        of the rod's postion vector and 1s elsewhere.
    %}
    mask = zeros(const.num_nodes, 1);
    spacing = int32(const.num_nodes/100);
    for i = [1:spacing:const.num_nodes-1, const.num_nodes]
        mask(i) = 1;
    end
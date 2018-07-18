function update_animation(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = data.u + y';

    % Joint
    clearpoints(lines.beam);
    clearpoints(lines.rod_b);
    addpoints(lines.beam, x, full(data.w));
    addpoints(lines.rod_b, 1+(0*y), full(rod_pos));
    
    % Rod's top
    clearpoints(lines.rod_t);
    addpoints(lines.rod_t, 1+(0*y), full(rod_pos));
    
    % Beam's velocity
    clearpoints(lines.beam_velo);
    addpoints(lines.beam_velo, x, full(data.wt));
    
    % Rod's velocity
    clearpoints(lines.rod_velo);
    addpoints(lines.rod_velo, y, full(data.ut));
    
    % Rod's temp
    clearpoints(lines.rod_temp);
    addpoints(lines.rod_temp, y, full([0; data.phi]));
    
    drawnow;
    
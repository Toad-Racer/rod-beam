function update_secondary_plots(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    
    % Beam's velocity
    clearpoints(lines.beam_velo);
    addpoints(lines.beam_velo, x, full(data.wt));
    
    % Rod's velocity
    clearpoints(lines.rod_velo);
    addpoints(lines.rod_velo, y, full(data.ut));
    
    % Rod's temp
    clearpoints(lines.rod_temp);
    addpoints(lines.rod_temp, y, full([0; data.phi]));
    
    % Stress on Rod's top
    addpoints(lines.sigma_dt, data.t, full(data.sigma_dt));
    
    % Energy
    addpoints(lines.energy, data.t, full(data.energy));
    addpoints(lines.accounted_energy, data.t, full(data.energy + data.lost_energy));
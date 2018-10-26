function frame = update_figures(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = data.u + y';
    
    % Stress on Rod's top
    addpoints(lines.sigma_dt, data.t, full(data.sigma_dt));
    
    % Energy
    addpoints(lines.energy, data.t, full(data.energy));
    addpoints(lines.accounted_energy, data.t, full(data.energy + data.lost_energy));
    
    % Tip of rod
    addpoints(lines.tip, data.t, full(data.u(end)));
    
    % Stress in Joint
    addpoints(lines.sigma_db, data.t, full(data.sigma_db));
    
    % Beam and rod
    lines.beam.YData = data.w;
    lines.rod.YData = rod_pos;
    lines.rod.CData = [0; data.phi];
    
    % Rod's temperature
    clearpoints(lines.rod_temp);
    addpoints(lines.rod_temp, y, full([0; data.phi]));
    
    frame = getframe(gcf);
    drawnow;
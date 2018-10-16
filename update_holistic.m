function frame = update_holistic(lines, data, const)
    % Stress on Rod's top
    addpoints(lines.sigma_dt, data.t, full(data.sigma_dt));
    
    % Energy
    addpoints(lines.energy, data.t, full(data.energy));
    addpoints(lines.accounted_energy, data.t, full(data.energy + data.lost_energy));
    
    % Tip of rod
    addpoints(lines.tip, data.t, full(data.u(end)));
    
    % Stress in Joint
    addpoints(lines.sigma_db, data.t, full(data.sigma_db));
    
    frame = getframe(gcf);
    drawnow;
function subFrames = update_transient(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = data.u + y';
    
    % Beam and rod
    lines.beam.YData = data.w;
    lines.rod.YData = rod_pos;
    lines.rod.CData = [0; data.phi];
    
    % Rod's top
    lines.rod_t.YData = rod_pos;
    lines.rod_t.CData = [0; data.phi];
    
    % Joint
    lines.beam_j.YData = data.w;
    lines.rod_j.YData = rod_pos;
    lines.rod_j.CData = [0; data.phi];
    
    % Velocities
    clearpoints(lines.ut);
    clearpoints(lines.wt);
    clearpoints(lines.theta_t);
    addpoints(lines.ut, y, full(data.ut));
    addpoints(lines.wt, x, full(data.wt));
    addpoints(lines.theta_t, x, full(data.theta_t));
    
    figs = findobj('Type', 'figure');
    for i = 1:size(figs, 1)
        subFrames(i) = getframe(figs(i));
    end
    drawnow;
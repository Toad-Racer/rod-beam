function update_transient(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = data.u + y';

    % Beam and rod
    lines.beam.YData = data.w;
    lines.rod.YData = rod_pos;
    lines.rod.CData = [0; data.phi];

    % Velocities
    clearpoints(lines.ut);
    clearpoints(lines.wt);
    clearpoints(lines.theta_t);
    addpoints(lines.ut, y, full(data.ut));
    addpoints(lines.wt, x, full(data.wt));
    addpoints(lines.theta_t, x, full(data.theta_t));

    % Beam's displacement
    clearpoints(lines.w);
    addpoints(lines.w, x, full(data.w));

    drawnow;
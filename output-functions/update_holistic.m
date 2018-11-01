function update_holistic(lines, data, const)
    % Stress on Rod's top
    addpoints(lines.sigma_dt, data.t, full(data.sigma_dt));

    % Energy
    addpoints(lines.energy, data.t, full(data.energy));

    % Tip of rod
    addpoints(lines.tip, data.t, full(data.u(end)));

    drawnow;
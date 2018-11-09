function save_holistic(lines, holistic_data)
    addpoints(lines.sigma_dt, holistic_data.t, holistic_data.sigma_dt);
    addpoints(lines.energy, holistic_data.t, holistic_data.energy);
    addpoints(lines.tip, holistic_data.t, holistic_data.tip);
    drawnow;

    for i = 1:size(lines.figs, 1)
        saveas(lines.figs(i), sprintf('out/holistic-%d', i), 'epsc');
        savefig(lines.figs(i), sprintf('out/holistic-%d.fig', i));
    end

    close(lines.figs);
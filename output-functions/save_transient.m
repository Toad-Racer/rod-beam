function save_transient(figs, lines, data, time_step, const)
    update_transient(lines, data, const);
    for i = 1:size(figs, 1)
        saveas(figs(i), sprintf('out/timeStep%d-%d', time_step, i), 'epsc');
        savefig(figs(i), sprintf('out/timeStep%d-%d.fig', time_step, i));
    end
function fn = plot_and_wait_fn(plot_fn)
    fn = @(state, data, const) plot_and_wait(plot_fn, state, data, const);
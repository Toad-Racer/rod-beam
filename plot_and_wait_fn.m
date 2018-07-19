function fn = plot_and_wait_fn(plot_fn)
    %{
     Uses a given plot function to construct a new plot function that waits
     for input after plotting.

     @param    plot_fn       The plot function to wrap.

     @return    fn    A function that calls plot_fn and then waits for
                      input
    %}
    fn = @(state, data, const) plot_and_wait(plot_fn, state, data, const);
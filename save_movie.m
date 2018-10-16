function save_movie(output, sim)
    create_movie(output.frames, (sim.const.num_steps+1)/(30*sim.const.T), 'out/rod-beam-sim.avi');
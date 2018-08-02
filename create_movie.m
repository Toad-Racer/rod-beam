function create_movie(frames, fps, filename)
    writer = VideoWriter(filename);
    writer.FrameRate = fps;
    
    open(writer);
    for i = 1:length(frames)
        writeVideo(writer, frames(i));
    end
    close(writer);
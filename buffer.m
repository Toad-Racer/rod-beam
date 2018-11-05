function bufferObj = buffer(data, max_size)
    offset = 0;

    bufferObj = struct('disp', @buffer_display, ...
                       'push', @buffer_push, ...
                       'peek', @buffer_peek);

    function buffer_display
        disp(data);
    end

    function buffer_push(value)
        data(offset+1) = value;
        offset = mod(offset+1, max_size);
    end

    function val = buffer_peek()
        val = data(offset+1);
    end
end

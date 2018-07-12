function merged_struct = merge_structs(varargin)
    %{
     Combines multiple structs into one. If a field is present in more
     than one of the structs, its furthest right value in the args list
     will be its value in the result.

     @param    varargin       Any number of structs.

     @return    merged_struct    A struct with all the fields of the input
                                 structs.
    %}
    merged_struct = struct();
    if nargin > 0
        merged_struct = varargin{1};
        for struct_i = 2:nargin
            fields = fieldnames(varargin{struct_i});
            for field_i = 1:length(fields)
                merged_struct.(fields{field_i}) = varargin{struct_i}.(fields{field_i});
            end
        end
    end
    
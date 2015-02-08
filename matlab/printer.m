% this is just being used as a namespace
classdef printer
    methods (Static = true)
        function str = pr_str(obj, print_readably)
            switch class(obj)
            case 'types.Symbol'
                str = obj.name;
            case 'double'
                str = num2str(obj);
            case 'char'
                if print_readably
                    str = strrep(obj, '\', '\\');
                    str = strrep(str, '"', '\"');
                    str = strrep(str, char(10), '\n');
                    str = strcat('"', str, '"');
                else
                    str = obj;
                end
            case 'cell'
                strs = cellfun(@(x) printer.pr_str(x, print_readably), ...
                               obj, 'UniformOutput', false);
                str = strcat('(', strjoin(strs, ' '), ')');
            case 'types.Nil'
                str = 'nil';
            case 'logical'
                if eq(obj, true)
                    str = 'true';
                else
                    str = 'false';
                end
            otherwise
                str = '#<unknown>';
            end
        end
    end
end

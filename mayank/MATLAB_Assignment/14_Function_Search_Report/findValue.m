function [firstIndex, occurrences] = findValue(arr, target)
% findValue  Linear search for target inside arr
%   firstIndex  - 1-based position of the first match (-1 when absent)
%   occurrences - total number of matches

firstIndex = -1;
occurrences = 0;

pos = 1;
while pos <= numel(arr)
    if arr(pos) == target
        occurrences = occurrences + 1;
        if firstIndex == -1
            firstIndex = pos;
        end
    end
    pos = pos + 1;
end
end

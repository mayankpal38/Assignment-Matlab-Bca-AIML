function [total, average, minimum, maximum] = arraySummary(arr)
% arraySummary  Total, mean, smallest and largest element of arr
% Smallest and largest are tracked by hand (no min() / max()).

total = 0; average = NaN; minimum = NaN; maximum = NaN;
count = numel(arr);
if count == 0
    return;
end

minimum = arr(1);
maximum = arr(1);
i = 1;
while i <= count
    total = total + arr(i);
    if arr(i) < minimum
        minimum = arr(i);
    end
    if arr(i) > maximum
        maximum = arr(i);
    end
    i = i + 1;
end
average = total / count;
end

function [positives, negatives, zeroes, evens, odds] = classifyArray(arr)
% classifyArray  Counts positive, negative and zero elements, and the
% even / odd elements among the INTEGER values only (fractions skipped)

positives = 0; negatives = 0; zeroes = 0;
evens = 0; odds = 0;

for k = 1:numel(arr)
    x = arr(k);

    % sign category
    if x > 0
        positives = positives + 1;
    elseif x < 0
        negatives = negatives + 1;
    else
        zeroes = zeroes + 1;
    end

    % parity category (integers only)
    if x == round(x)
        if rem(x, 2) == 0
            evens = evens + 1;
        else
            odds = odds + 1;
        end
    end
end
end

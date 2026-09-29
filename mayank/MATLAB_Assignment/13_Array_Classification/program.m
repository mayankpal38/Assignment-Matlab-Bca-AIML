% Program 13: Array Classification and Summary
% Counts positive / negative / zero values, even / odd integers,
% the positive and negative sums, and the most frequent category.
% Fractions have no parity, so they are left out of the even/odd count.
clc; clear;

readings = [13 -6 0 24 -17 8.5 -2 0 31 -9 16 0 -11 5];

nPositive = 0; nNegative = 0; nZero = 0;
nEven = 0; nOdd = 0; nFraction = 0;
positiveSum = 0; negativeSum = 0;

for idx = 1:numel(readings)
    r = readings(idx);

    % sign
    if r > 0
        nPositive = nPositive + 1;
        positiveSum = positiveSum + r;
    elseif r < 0
        nNegative = nNegative + 1;
        negativeSum = negativeSum + r;
    else
        nZero = nZero + 1;
    end

    % parity
    if r ~= floor(r)
        nFraction = nFraction + 1;
    elseif rem(r, 2) == 0
        nEven = nEven + 1;
    else
        nOdd = nOdd + 1;
    end
end

groupNames  = {'Positive', 'Negative', 'Zero', 'Even', 'Odd'};
groupCounts = [nPositive nNegative nZero nEven nOdd];

% largest count first, then every category that reaches it (handles ties)
topCount = groupCounts(1);
for g = 2:numel(groupCounts)
    if groupCounts(g) > topCount
        topCount = groupCounts(g);
    end
end
leaders = '';
for g = 1:numel(groupCounts)
    if groupCounts(g) == topCount
        if isempty(leaders)
            leaders = groupNames{g};
        else
            leaders = [leaders ' & ' groupNames{g}];
        end
    end
end

sumId = fopen('output.txt', 'w');
if sumId == -1
    error('output.txt could not be created');
end
fprintf(sumId, '::: ARRAY CLASSIFICATION :::\n');
fprintf(sumId, 'Input (%d values): ', numel(readings));
fprintf(sumId, '%g ', readings);
fprintf(sumId, '\n\n');
for g = 1:numel(groupNames)
    fprintf(sumId, '%-9s count : %d\n', groupNames{g}, groupCounts(g));
end
fprintf(sumId, 'Fractions (no parity) : %d\n', nFraction);
fprintf(sumId, '\nSum of positives : %g\n', positiveSum);
fprintf(sumId, 'Sum of negatives : %g\n', negativeSum);
fprintf(sumId, '\nMost frequent category : %s (%d elements)\n', leaders, topCount);
fclose(sumId);

type('output.txt');

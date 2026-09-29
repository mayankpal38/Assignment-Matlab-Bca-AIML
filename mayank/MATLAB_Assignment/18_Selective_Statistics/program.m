% Program 18: Selective Processing with continue
% Values <= 0 are skipped with continue; count, sum and average are
% computed from the positive values only. A set with no positive value
% is reported safely instead of dividing by zero.
clc; clear;

sets = {[8 -3 0 15 -11 22 0 -6 4 19 -1], ...
        [-4 0 -9 -2 0 -15], ...
        [2.5 -1 7.5 0 12]};

statId = fopen('output.txt', 'w');
if statId == -1
    error('Cannot open output.txt');
end
fprintf(statId, '*** POSITIVE-ONLY STATISTICS ***\n');

for s = 1:numel(sets)
    current = sets{s};
    kept = [];
    keptSum = 0;
    for v = 1:numel(current)
        if current(v) <= 0
            continue;           % ignore zero and negative values
        end
        kept(end+1) = current(v);
        keptSum = keptSum + current(v);
    end

    fprintf(statId, '\nSet %d : ', s);
    fprintf(statId, '%g ', current);
    fprintf(statId, '\n');
    if isempty(kept)
        fprintf(statId, '  No positive values - count is 0, sum and average not defined.\n');
    else
        fprintf(statId, '  Positives used : ');
        fprintf(statId, '%g ', kept);
        fprintf(statId, '\n  Count          : %d\n', numel(kept));
        fprintf(statId, '  Sum            : %g\n', keptSum);
        fprintf(statId, '  Average        : %.3f\n', keptSum / numel(kept));
    end
end
fclose(statId);

type('output.txt');

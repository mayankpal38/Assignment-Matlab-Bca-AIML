% Program 16: Multi-output Array Summary Function
% arraySummary() is called for three arrays, one of them all-negative
clc; clear;

inputs = {[27 46 13 58 35 9], ...
          [-8 -31 -15 -4 -22], ...
          [12.5 -7 0 19 -3.5 6]};
names  = {'Positive set', 'Negative set', 'Mixed set'};

sumId = fopen('output.txt', 'w');
if sumId == -1
    error('output.txt could not be created');
end
fprintf(sumId, '### arraySummary RESULTS ###\n');

for a = 1:numel(inputs)
    [total, average, minimum, maximum] = arraySummary(inputs{a});
    fprintf(sumId, '\n%s -> [', names{a});
    fprintf(sumId, ' %g', inputs{a});
    fprintf(sumId, ' ]\n');
    fprintf(sumId, '   total   : %g\n', total);
    fprintf(sumId, '   average : %.3f\n', average);
    fprintf(sumId, '   minimum : %g\n', minimum);
    fprintf(sumId, '   maximum : %g\n', maximum);
end
fclose(sumId);

type('output.txt');

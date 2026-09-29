% Program 14: Function-based Search + Report File
% numbers.txt : all values on one line, separated by commas
% Each target is searched with findValue(); -1 means "not present".
clc; clear;

dataId = fopen('numbers.txt', 'r');
if dataId == -1
    disp('numbers.txt could not be opened - search aborted.');
    return;
end
rawLine = fgetl(dataId);
fclose(dataId);
series = sscanf(rawLine, '%f,')';

targets = [8 27 41 100];

repId = fopen('output.txt', 'w');
if repId == -1
    error('output.txt could not be created');
end
fprintf(repId, '--- findValue SEARCH REPORT ---\n');
fprintf(repId, 'Values from numbers.txt (%d): ', numel(series));
fprintf(repId, '%d ', series);
fprintf(repId, '\n\n%-8s| %-12s| %-12s| %s\n', 'Target', 'First index', 'Occurrences', 'Result');
fprintf(repId, '%s\n', repmat('-', 1, 48));

for t = 1:numel(targets)
    [where, howMany] = findValue(series, targets(t));
    if where == -1
        verdict = 'absent';
    else
        verdict = 'present';
    end
    fprintf(repId, '%-8d| %-12d| %-12d| %s\n', targets(t), where, howMany, verdict);
end
fclose(repId);

type('output.txt');

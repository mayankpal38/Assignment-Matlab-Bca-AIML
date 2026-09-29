% Program 6: Second Largest Distinct Value with Report
% One pass keeps the largest and the second largest DISTINCT values,
% so repeated copies of the maximum are ignored. sort() is not used.
clc; clear;

samples = {[37 64 18 91 55 91 64 73 91 12], ...
           [26 26 26 26], ...
           [-15 -40 -15 -8 -22]};

outFile = fopen('output.txt', 'w');
if outFile == -1
    error('output.txt could not be created');
end
fprintf(outFile, '=+=+= SECOND LARGEST DISTINCT VALUE =+=+=\n');

for s = 1:length(samples)
    list = samples{s};
    largest = -Inf;
    runnerUp = -Inf;
    for p = 1:length(list)
        item = list(p);
        if item > largest
            runnerUp = largest;       % old maximum moves down
            largest = item;
        elseif item < largest && item > runnerUp
            runnerUp = item;          % strictly smaller than max only
        end
    end

    fprintf(outFile, '\nArray %d : ', s);
    fprintf(outFile, '%d ', list);
    fprintf(outFile, '\n  Largest value        : %d\n', largest);
    if runnerUp == -Inf
        fprintf(outFile, '  Second largest       : not available (all values are equal)\n');
    else
        fprintf(outFile, '  Second largest       : %d\n', runnerUp);
    end
end
fclose(outFile);

type('output.txt');

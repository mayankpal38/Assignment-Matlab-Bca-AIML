% Program 11: Read and Analyze Numbers from File
% input.txt : one number per line (positive, negative and zero values)
% The program confirms the file opened before reading it.
clc; clear;

inName  = 'input.txt';
outName = 'output.txt';

inId = fopen(inName, 'r');
if inId == -1
    fprintf('Error: %s could not be opened. Nothing analysed.\n', inName);
    return;
end
nums = fscanf(inId, '%f')';
fclose(inId);

if isempty(nums)
    fprintf('%s has no numeric values.\n', inName);
    return;
end

posList = []; negList = []; zeroTotal = 0;
grandSum = 0;
smallest = nums(1);
largest = nums(1);

k = 1;
while k <= length(nums)
    current = nums(k);
    grandSum = grandSum + current;

    if current > 0
        posList = [posList current];
    elseif current < 0
        negList = [negList current];
    else
        zeroTotal = zeroTotal + 1;
    end

    if current < smallest
        smallest = current;
    elseif current > largest
        largest = current;
    end
    k = k + 1;
end
meanValue = grandSum / length(nums);

outId = fopen(outName, 'w');
if outId == -1
    error('Failed to open %s for writing', outName);
end
fprintf(outId, '=== NUMBERS READ FROM %s ===\n', inName);
fprintf(outId, '%g  ', nums);
fprintf(outId, '\n\nCount of values   : %d\n', length(nums));
fprintf(outId, 'Positive values   : %d  ->  ', length(posList)); fprintf(outId, '%g  ', posList);
fprintf(outId, '\nNegative values   : %d  ->  ', length(negList)); fprintf(outId, '%g  ', negList);
fprintf(outId, '\nZero values       : %d\n', zeroTotal);
fprintf(outId, 'Sum               : %.2f\n', grandSum);
fprintf(outId, 'Average           : %.4f\n', meanValue);
fprintf(outId, 'Minimum           : %g\n', smallest);
fprintf(outId, 'Maximum           : %g\n', largest);
fclose(outId);

type(outName);

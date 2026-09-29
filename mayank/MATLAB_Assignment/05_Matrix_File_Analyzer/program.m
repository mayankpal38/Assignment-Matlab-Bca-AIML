% Program 5: Matrix File Analyzer
% matrix.txt : one matrix row per line, values separated by spaces
% Finds overall max/min with positions (nested loops), every row sum
% and the row having the highest sum. Results go to output.txt
clc; clear;

srcName = 'matrix.txt';
srcId = fopen(srcName, 'r');
if srcId == -1
    fprintf('Error: %s is missing.\n', srcName);
    return;
end

% column count is taken from the first line, then the whole file is read
headerLine = fgetl(srcId);
colTotal = length(sscanf(headerLine, '%f'));
frewind(srcId);
table = fscanf(srcId, '%f', [colTotal, Inf])';
fclose(srcId);

rowTotal = size(table, 1);

hiVal = table(1, 1); hiAt = [1 1];
loVal = table(1, 1); loAt = [1 1];
rowTotals = zeros(1, rowTotal);

for r = 1:rowTotal
    for c = 1:colTotal
        element = table(r, c);
        rowTotals(r) = rowTotals(r) + element;
        if element > hiVal
            hiVal = element;
            hiAt = [r c];
        end
        if element < loVal
            loVal = element;
            loAt = [r c];
        end
    end
end

heaviest = 1;
for r = 2:rowTotal
    if rowTotals(r) > rowTotals(heaviest)
        heaviest = r;
    end
end

dstId = fopen('output.txt', 'w');
if dstId == -1
    error('Failed to create output.txt');
end
fprintf(dstId, '~~~ MATRIX FILE ANALYZER ~~~\n');
fprintf(dstId, 'Loaded %d rows x %d columns from %s\n\n', rowTotal, colTotal, srcName);
for r = 1:rowTotal
    fprintf(dstId, '%5d', table(r, :));
    fprintf(dstId, '\n');
end
fprintf(dstId, '\nLargest element  : %d  (row %d, column %d)\n', hiVal, hiAt(1), hiAt(2));
fprintf(dstId, 'Smallest element : %d  (row %d, column %d)\n\n', loVal, loAt(1), loAt(2));
fprintf(dstId, 'Row sums:\n');
for r = 1:rowTotal
    fprintf(dstId, '  row %d -> %d\n', r, rowTotals(r));
end
fprintf(dstId, '\nRow %d has the highest sum (%d)\n', heaviest, rowTotals(heaviest));
fclose(dstId);

type('output.txt');

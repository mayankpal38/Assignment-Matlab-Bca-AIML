% Program 2: Row-wise Matrix Analyzer
% For every row: sum, average and largest element (found with loops)
% Then reports the row whose sum is the greatest
clc; clear;

grid = [14 -3 22  9 17;
         6 25 11 -8 19;
        21  4 13 16 10;
        -5 18 27  7 12];

rowCount = size(grid, 1);
colCount = size(grid, 2);

rowSums  = zeros(rowCount, 1);
rowMeans = zeros(rowCount, 1);
rowPeaks = zeros(rowCount, 1);

% walk each row element by element
for row = 1:rowCount
    total = 0;
    peak = grid(row, 1);
    for col = 1:colCount
        cellValue = grid(row, col);
        total = total + cellValue;
        if cellValue > peak
            peak = cellValue;
        end
    end
    rowSums(row)  = total;
    rowMeans(row) = total / colCount;
    rowPeaks(row) = peak;
end

% row with the greatest sum (first one wins on a tie)
bestRow = 1;
for row = 2:rowCount
    if rowSums(row) > rowSums(bestRow)
        bestRow = row;
    end
end

reportId = fopen('output.txt', 'w');
if reportId == -1
    error('output.txt could not be created');
end
fprintf(reportId, '*** ROW-WISE MATRIX ANALYZER ***\n');
fprintf(reportId, 'Input matrix (%d x %d):\n', rowCount, colCount);
for row = 1:rowCount
    fprintf(reportId, '%5d', grid(row, :));
    fprintf(reportId, '\n');
end
fprintf(reportId, '\n%-7s| %6s | %8s | %6s\n', 'Row No', 'Sum', 'Mean', 'Peak');
fprintf(reportId, '%s\n', repmat('-', 1, 36));
for row = 1:rowCount
    fprintf(reportId, '%-7d| %6d | %8.2f | %6d\n', row, rowSums(row), rowMeans(row), rowPeaks(row));
end
fprintf(reportId, '\nGreatest row sum is %d in row number %d\n', rowSums(bestRow), bestRow);
fclose(reportId);

type('output.txt');

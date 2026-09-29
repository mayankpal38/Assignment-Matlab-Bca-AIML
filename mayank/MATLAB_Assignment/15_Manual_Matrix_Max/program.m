% Program 15: Manual Matrix Maximum with Position
% Nested loops scan every element; max() is not used for the search.
% The running maximum starts at element (1,1) (not at 0), so a matrix
% whose elements are all negative is handled correctly.
clc; clear;

testMatrices = {[23 -8 41 12; 5 37 -19 41; 30 -2 16 9], ...
                [-14 -6 -27; -9 -33 -3; -21 -11 -18]};
titles = {'Mixed values', 'All negative'};

maxId = fopen('output.txt', 'w');
if maxId == -1
    error('Unable to create output.txt');
end
fprintf(maxId, '>>> MATRIX MAXIMUM (manual search) <<<\n');

for m = 1:numel(testMatrices)
    mat = testMatrices{m};
    [nRow, nCol] = size(mat);

    bestValue = mat(1, 1);
    bestRow = 1;
    bestCol = 1;
    for i = 1:nRow
        for j = 1:nCol
            if mat(i, j) > bestValue       % strict > keeps the first occurrence
                bestValue = mat(i, j);
                bestRow = i;
                bestCol = j;
            end
        end
    end

    fprintf(maxId, '\nMatrix %d - %s (%dx%d)\n', m, titles{m}, nRow, nCol);
    for i = 1:nRow
        fprintf(maxId, '%6d', mat(i, :));
        fprintf(maxId, '\n');
    end
    fprintf(maxId, 'Maximum element : %d\n', bestValue);
    fprintf(maxId, 'Located at      : (row %d, column %d)\n', bestRow, bestCol);
end
fclose(maxId);

type('output.txt');

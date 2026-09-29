% Program 12: Validated Manual Matrix Multiplication
% A*B is possible only when columns(A) == rows(B).
% Valid pairs are multiplied with three nested loops and the answer is
% checked against the built-in A*B.
clc; clear;

leftMats  = {[4 -1; 2 3; -5 6], [3 8; -2 5], [2 -3; 1 4]};
rightMats = {[1 0 -2 3; 7 -4 5 2], [1 2; 3 4; 5 6], [5 1; -2 6]};

mulId = fopen('output.txt', 'w');
if mulId == -1
    error('Unable to create output.txt');
end
fprintf(mulId, '==== MANUAL MATRIX MULTIPLICATION ====\n');

for t = 1:numel(leftMats)
    A = leftMats{t};
    B = rightMats{t};
    [aRows, aCols] = size(A);
    [bRows, bCols] = size(B);
    fprintf(mulId, '\nPair %d : A is %dx%d, B is %dx%d\n', t, aRows, aCols, bRows, bCols);

    % dimension check
    if aCols ~= bRows
        fprintf(mulId, '  Not possible - A has %d column(s) but B has %d row(s).\n', aCols, bRows);
        continue;
    end

    C = zeros(aRows, bCols);
    for i = 1:aRows
        for j = 1:bCols
            acc = 0;
            for k = 1:aCols
                acc = acc + A(i, k) * B(k, j);
            end
            C(i, j) = acc;
        end
    end

    fprintf(mulId, '  Manual product C (%dx%d):\n', aRows, bCols);
    for i = 1:aRows
        fprintf(mulId, '  ');
        fprintf(mulId, '%7d', C(i, :));
        fprintf(mulId, '\n');
    end

    builtIn = A * B;
    if isequal(C, builtIn)
        fprintf(mulId, '  Comparison with A*B : identical\n');
    else
        fprintf(mulId, '  Comparison with A*B : DIFFERENT\n');
    end
end
fclose(mulId);

type('output.txt');

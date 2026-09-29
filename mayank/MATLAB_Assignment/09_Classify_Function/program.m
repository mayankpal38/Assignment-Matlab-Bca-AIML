% Program 9: Reusable Array Classification Function
% Runs classifyArray() on two arrays and prints a side-by-side comparison
clc; clear;

batchA = [15 -22 0 8 -13 27 0 -4 6];
batchB = [-9 3.5 12 -17 0 21 -30 5 -1.5 14];

countsA = zeros(1, 5);
countsB = zeros(1, 5);
[countsA(1), countsA(2), countsA(3), countsA(4), countsA(5)] = classifyArray(batchA);
[countsB(1), countsB(2), countsB(3), countsB(4), countsB(5)] = classifyArray(batchB);

labels = {'Positive', 'Negative', 'Zero', 'Even (int)', 'Odd (int)'};

cmpId = fopen('output.txt', 'w');
if cmpId == -1
    error('output.txt could not be opened');
end
fprintf(cmpId, '[ classifyArray COMPARISON ]\n');
fprintf(cmpId, 'Batch A : '); fprintf(cmpId, '%g ', batchA);
fprintf(cmpId, '\nBatch B : '); fprintf(cmpId, '%g ', batchB);
fprintf(cmpId, '\n\n%-12s %8s %8s %11s\n', 'Category', 'Batch A', 'Batch B', 'Diff (A-B)');
fprintf(cmpId, '%s\n', repmat('-', 1, 42));
for k = 1:numel(labels)
    fprintf(cmpId, '%-12s %8d %8d %+11d\n', labels{k}, countsA(k), countsB(k), countsA(k) - countsB(k));
end
fclose(cmpId);

type('output.txt');

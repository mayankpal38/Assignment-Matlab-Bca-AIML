% Program 10: Search with First Position and Occurrence Count
% First position -> loop stopped with break at the first hit
% Occurrences    -> a second full loop over the array
% Positions are 1-based (MATLAB indexing)
clc; clear;

values = [44 17 62 29 17 85 17 50 29 17];
queries = [17 29 99];

srchId = fopen('output.txt', 'w');
if srchId == -1
    error('Could not create output.txt');
end
fprintf(srchId, '### MANUAL SEARCH ###\n');
fprintf(srchId, 'Data (%d items): ', length(values));
fprintf(srchId, '%d ', values);
fprintf(srchId, '\n');

for q = 1:length(queries)
    key = queries(q);

    firstPos = 0;                       % 0 means "not seen yet"
    for pos = 1:length(values)
        if values(pos) == key
            firstPos = pos;
            break;
        end
    end

    hits = 0;
    for pos = 1:length(values)
        if values(pos) == key
            hits = hits + 1;
        end
    end

    fprintf(srchId, '\nSearching for %d ...\n', key);
    if firstPos == 0
        fprintf(srchId, '  %d does not occur anywhere in the data.\n', key);
    else
        fprintf(srchId, '  first seen at index %d\n', firstPos);
        fprintf(srchId, '  appears %d time(s)\n', hits);
    end
end
fclose(srchId);

type('output.txt');

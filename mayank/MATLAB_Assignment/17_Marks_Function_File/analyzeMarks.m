function [avgMark, topMark, passed, failed, goodMarks, badMarks] = analyzeMarks(marks)
% analyzeMarks  Validates marks and summarises the valid ones
%   goodMarks - marks inside 0..100 (used for every calculation)
%   badMarks  - marks outside 0..100 (reported only, never used)
%   A valid mark of 40 or more is a pass.

passMark = 40;

goodMarks = [];
badMarks = [];
for k = 1:numel(marks)
    if marks(k) < 0 || marks(k) > 100
        badMarks = [badMarks marks(k)];
    else
        goodMarks = [goodMarks marks(k)];
    end
end

avgMark = 0; topMark = 0; passed = 0; failed = 0;
if isempty(goodMarks)
    return;
end

runningSum = 0;
topMark = goodMarks(1);
for k = 1:numel(goodMarks)
    runningSum = runningSum + goodMarks(k);
    if goodMarks(k) > topMark
        topMark = goodMarks(k);
    end
    if goodMarks(k) >= passMark
        passed = passed + 1;
    else
        failed = failed + 1;
    end
end
avgMark = runningSum / numel(goodMarks);
end

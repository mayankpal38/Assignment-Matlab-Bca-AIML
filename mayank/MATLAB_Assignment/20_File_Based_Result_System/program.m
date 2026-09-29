% Program 20: File-based Student Result System
%
% INPUT FORMAT of marks.txt
%   one student per line, values separated by commas (no header):
%       RollNo,Sub1,Sub2,Sub3,Sub4,Sub5
%   every subject is marked out of 100
%   example line ->  2101,78,64,55,82,71
%
% RESULT RULE
%   PASS : every subject >= 35  AND  overall percentage >= 40
%   FAIL : otherwise
clc; clear;

numSubjects = 5;
subjectMin = 35;
percentMin = 40;

inId = fopen('marks.txt', 'r');
if inId == -1
    disp('marks.txt could not be opened - no report produced.');
    return;
end

records = [];
lineNo = 0;
textLine = fgetl(inId);
while ischar(textLine)
    lineNo = lineNo + 1;
    fields = sscanf(textLine, '%f,')';
    if numel(fields) == numSubjects + 1
        records(end+1, :) = fields;
    elseif ~isempty(strtrim(textLine))
        fprintf('Line %d skipped: expected %d values.\n', lineNo, numSubjects + 1);
    end
    textLine = fgetl(inId);
end
fclose(inId);

outId = fopen('result.txt', 'w');
if outId == -1
    error('result.txt could not be created');
end
fprintf(outId, '========== STUDENT RESULT SHEET ==========\n');
fprintf(outId, 'Rule: each subject >= %d and percentage >= %d\n\n', subjectMin, percentMin);
fprintf(outId, '%-6s', 'Roll');
for s = 1:numSubjects
    fprintf(outId, '%5s', sprintf('S%d', s));
end
fprintf(outId, '%7s %8s   %s\n', 'Total', 'Percent', 'Result');
fprintf(outId, '%s\n', repmat('-', 1, 60));

passList = 0;
failList = 0;
for r = 1:size(records, 1)
    rollNo = records(r, 1);
    scores = records(r, 2:end);

    marksTotal = 0;
    weakSubject = false;
    for s = 1:numSubjects
        marksTotal = marksTotal + scores(s);
        if scores(s) < subjectMin
            weakSubject = true;
        end
    end
    percent = marksTotal / (numSubjects * 100) * 100;

    if weakSubject
        verdict = 'FAIL (subject below 35)';
        failList = failList + 1;
    elseif percent < percentMin
        verdict = 'FAIL (percentage below 40)';
        failList = failList + 1;
    else
        verdict = 'PASS';
        passList = passList + 1;
    end

    fprintf(outId, '%-6d', rollNo);
    fprintf(outId, '%5d', scores);
    fprintf(outId, '%7d %7.2f%%   %s\n', marksTotal, percent, verdict);
end

fprintf(outId, '%s\n', repmat('-', 1, 60));
fprintf(outId, 'Students: %d | Passed: %d | Failed: %d\n', size(records, 1), passList, failList);
fclose(outId);

type('result.txt');

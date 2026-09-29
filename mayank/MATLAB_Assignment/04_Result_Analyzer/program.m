% Program 4: Student Result Analyzer
% Marks outside 0-100 are rejected and never enter the calculations.
% Pass rule used here: mark >= 33
clc; clear;

studentMarks = [56 91 -12 47 33 101 68 29 84 -1 73 45 150 62 18];
passMark = 33;

acceptedMarks = [];
rejectedMarks = [];
sumAccepted = 0;
bestMark = -Inf;
worstMark = Inf;
passTally = 0;
failTally = 0;

% single pass: validate, accumulate and classify
for idx = 1:length(studentMarks)
    score = studentMarks(idx);
    if score < 0 || score > 100
        rejectedMarks(end+1) = score;
        continue;
    end
    acceptedMarks(end+1) = score;
    sumAccepted = sumAccepted + score;
    if score > bestMark
        bestMark = score;
    end
    if score < worstMark
        worstMark = score;
    end
    if score >= passMark
        passTally = passTally + 1;
    else
        failTally = failTally + 1;
    end
end

sheetId = fopen('output.txt', 'w');
if sheetId == -1
    error('output.txt could not be opened');
end
fprintf(sheetId, '###### STUDENT RESULT ANALYZER ######\n');
fprintf(sheetId, 'Marks entered   (%2d) : ', length(studentMarks));
fprintf(sheetId, '%d ', studentMarks);
fprintf(sheetId, '\nMarks accepted  (%2d) : ', length(acceptedMarks));
fprintf(sheetId, '%d ', acceptedMarks);
fprintf(sheetId, '\nMarks rejected  (%2d) : ', length(rejectedMarks));
fprintf(sheetId, '%d ', rejectedMarks);
fprintf(sheetId, '\n\n');

if isempty(acceptedMarks)
    fprintf(sheetId, 'Nothing to analyse - every mark was out of range.\n');
else
    fprintf(sheetId, 'Sum of valid marks   : %d\n', sumAccepted);
    fprintf(sheetId, 'Mean of valid marks  : %.2f\n', sumAccepted / length(acceptedMarks));
    fprintf(sheetId, 'Top score            : %d\n', bestMark);
    fprintf(sheetId, 'Bottom score         : %d\n', worstMark);
    fprintf(sheetId, 'Pass criterion       : mark >= %d\n', passMark);
    fprintf(sheetId, 'Students passed      : %d\n', passTally);
    fprintf(sheetId, 'Students failed      : %d\n', failTally);
end
fclose(sheetId);

type('output.txt');

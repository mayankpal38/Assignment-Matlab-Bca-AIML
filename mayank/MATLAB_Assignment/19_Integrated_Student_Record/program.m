% Program 19: Integrated Student Record Processor (capstone)
% student_marks.txt : one mark per line
% Steps: read file -> validate + summarise with resultSummary()
%        -> write the full report to final_report.txt
% A missing input file is reported (in the console and in the report)
% instead of crashing, and invalid marks are excluded from all results.
clc; clear;

marksFile  = 'student_marks.txt';
reportFile = 'final_report.txt';
cutoff = 35;

srcId = fopen(marksFile, 'r');
if srcId == -1
    errId = fopen(reportFile, 'w');
    if errId ~= -1
        fprintf(errId, 'REPORT NOT GENERATED: %s could not be opened.\n', marksFile);
        fclose(errId);
    end
    fprintf('Could not open %s - see %s.\n', marksFile, reportFile);
    return;
end
rawMarks = fscanf(srcId, '%f');
fclose(srcId);

summary = resultSummary(rawMarks, cutoff);

outId = fopen(reportFile, 'w');
if outId == -1
    error('Unable to create %s', reportFile);
end
fprintf(outId, '############################################\n');
fprintf(outId, '#     INTEGRATED STUDENT RECORD REPORT     #\n');
fprintf(outId, '############################################\n\n');
fprintf(outId, 'Input file        : %s\n', marksFile);
fprintf(outId, 'Entries read      : %d\n', numel(rawMarks));
fprintf(outId, 'Accepted (%2d)     : ', numel(summary.accepted));
fprintf(outId, '%g ', summary.accepted);
fprintf(outId, '\nRejected (%2d)     : ', numel(summary.rejected));
fprintf(outId, '%g ', summary.rejected);
fprintf(outId, '\nRejected marks lie outside 0-100 and are not used.\n\n');

fprintf(outId, '%-9s %-7s %-7s %s\n', 'Student', 'Mark', 'Grade', 'Result');
fprintf(outId, '%s\n', repmat('-', 1, 34));
for k = 1:numel(summary.accepted)
    mark = summary.accepted(k);
    if mark >= 80
        grade = 'A';
    elseif mark >= 60
        grade = 'B';
    elseif mark >= cutoff
        grade = 'C';
    else
        grade = 'F';
    end
    if mark >= cutoff
        outcome = 'PASS';
    else
        outcome = 'FAIL';
    end
    fprintf(outId, 'S%-8d %-7g %-7s %s\n', k, mark, grade, outcome);
end

fprintf(outId, '\n---------------- SUMMARY ----------------\n');
fprintf(outId, 'Total of valid marks : %g\n', summary.total);
fprintf(outId, 'Class average        : %.2f\n', summary.mean);
fprintf(outId, 'Highest mark         : %g\n', summary.best);
fprintf(outId, 'Lowest mark          : %g\n', summary.worst);
fprintf(outId, 'Pass mark            : %d\n', cutoff);
fprintf(outId, 'Passed / Failed      : %d / %d\n', summary.passes, summary.fails);
fprintf(outId, 'Pass percentage      : %.2f%%\n', summary.passRate);
fprintf(outId, 'Grades A/B/C/F       : %d / %d / %d / %d\n', summary.grades);
fprintf(outId, 'Overall result       : %s\n', summary.verdict);
fclose(outId);

type(reportFile);

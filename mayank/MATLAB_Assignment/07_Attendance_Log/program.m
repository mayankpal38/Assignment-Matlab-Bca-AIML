% Program 7: Persistent Attendance Log
% Every record is APPENDED to attendance.txt (mode 'a'), so older
% entries are never erased.
% Accepted status words: Present, Absent, Late, Leave (any letter case)
% Leave the name blank to stop entering records.
clc; clear;

allowedStatus = {'Present', 'Absent', 'Late', 'Leave'};
logName = 'attendance.txt';

logId = fopen(logName, 'a');
if logId == -1
    error('Unable to open %s in append mode', logName);
end

today = datestr(now, 'dd-mmm-yyyy');
saved = 0;
entryNo = 1;
while true
    studentName = strtrim(input(sprintf('[%d] Student name (blank to finish): ', entryNo), 's'));
    if isempty(studentName)
        break;
    end
    statusText = strtrim(input('    Status (Present/Absent/Late/Leave): ', 's'));

    % look the status up in the allowed list
    pick = 0;
    for s = 1:numel(allowedStatus)
        if strcmpi(statusText, allowedStatus{s})
            pick = s;
            break;
        end
    end

    if pick == 0
        fprintf('    "%s" is not an accepted status - record not saved.\n', statusText);
    else
        fprintf(logId, '%s  %-18s %s\n', today, studentName, allowedStatus{pick});
        saved = saved + 1;
        fprintf('    Saved %s as %s\n', studentName, allowedStatus{pick});
    end
    entryNo = entryNo + 1;
end
fclose(logId);

fprintf('\n%d new record(s) appended. Current log:\n', saved);
type(logName);

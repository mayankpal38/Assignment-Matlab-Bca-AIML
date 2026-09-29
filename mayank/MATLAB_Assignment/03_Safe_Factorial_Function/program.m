% Program 3: Validated Factorial Function (driver)
% Calls safeFactorial() for valid, boundary and invalid inputs
clc; clear;

cases = [6 1 -4 9 2.5 0 -0.5];

logId = fopen('output.txt', 'w');
if logId == -1
    error('Could not open output.txt for writing');
end
fprintf(logId, '>> safeFactorial test run <<\n\n');
fprintf(logId, '%-6s %-8s %-10s %s\n', 'Case', 'Input', 'Status', 'Result');

validRuns = 0;
for c = 1:length(cases)
    [answer, isValid] = safeFactorial(cases(c));
    if isValid
        validRuns = validRuns + 1;
        fprintf(logId, '%-6d %-8g %-10s %g\n', c, cases(c), 'ACCEPTED', answer);
    else
        fprintf(logId, '%-6d %-8g %-10s %s\n', c, cases(c), 'REJECTED', 'negative or non-integer input');
    end
end

fprintf(logId, '\nAccepted: %d   Rejected: %d\n', validRuns, length(cases) - validRuns);
fclose(logId);

type('output.txt');

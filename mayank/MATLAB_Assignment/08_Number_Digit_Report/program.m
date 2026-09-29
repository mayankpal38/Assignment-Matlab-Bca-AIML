% Program 8: Number Digit Analysis
% Digits are peeled off arithmetically (rem / floor) inside a while loop;
% the number is never converted to a string.
clc; clear;

numbersToCheck = [905286 43734];

rptId = fopen('output.txt', 'w');
if rptId == -1
    error('Cannot create output.txt');
end
fprintf(rptId, '<<< NUMBER DIGIT ANALYSIS >>>\n');

for n = 1:length(numbersToCheck)
    value = numbersToCheck(n);

    % only positive whole numbers are allowed
    if value <= 0 || value ~= round(value)
        fprintf(rptId, '\n%g is not a positive integer - skipped.\n', value);
        continue;
    end

    remaining = value;
    digitTotal = 0; digitSum = 0;
    evenDigits = 0; oddDigits = 0;
    mirror = 0;
    while remaining > 0
        lastDigit = rem(remaining, 10);
        digitTotal = digitTotal + 1;
        digitSum = digitSum + lastDigit;
        if rem(lastDigit, 2) == 0
            evenDigits = evenDigits + 1;
        else
            oddDigits = oddDigits + 1;
        end
        mirror = mirror * 10 + lastDigit;
        remaining = floor(remaining / 10);
    end

    fprintf(rptId, '\nNumber under test : %d\n', value);
    fprintf(rptId, '  How many digits : %d\n', digitTotal);
    fprintf(rptId, '  Digit sum       : %d\n', digitSum);
    fprintf(rptId, '  Even digits     : %d\n', evenDigits);
    fprintf(rptId, '  Odd digits      : %d\n', oddDigits);
    fprintf(rptId, '  Reverse         : %d\n', mirror);
    if mirror == value
        fprintf(rptId, '  Palindrome?     : YES\n');
    else
        fprintf(rptId, '  Palindrome?     : NO\n');
    end
end
fclose(rptId);

type('output.txt');

% Program 17: Marks Analysis Function + File Output
% analyzeMarks() does the validation and statistics;
% this script writes the complete analysis to result.txt
clc; clear;

classMarks = [67 88 -15 42 39 103 74 55 120 91 28 60];

[avgMark, topMark, passed, failed, goodMarks, badMarks] = analyzeMarks(classMarks);

resId = fopen('result.txt', 'w');
if resId == -1
    error('result.txt could not be created');
end
fprintf(resId, '====== MARKS ANALYSIS (analyzeMarks) ======\n');
fprintf(resId, 'Marks supplied       : ');
fprintf(resId, '%d ', classMarks);
fprintf(resId, '\nUsed (valid 0-100)   : ');
fprintf(resId, '%d ', goodMarks);
fprintf(resId, '\nIgnored (invalid)    : ');
fprintf(resId, '%d ', badMarks);
fprintf(resId, '\n\nValid marks counted  : %d\n', numel(goodMarks));
fprintf(resId, 'Average valid mark   : %.2f\n', avgMark);
fprintf(resId, 'Highest valid mark   : %d\n', topMark);
fprintf(resId, 'Pass (>= 40)         : %d\n', passed);
fprintf(resId, 'Fail (< 40)          : %d\n', failed);
fclose(resId);

type('result.txt');

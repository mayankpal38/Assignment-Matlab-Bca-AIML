function summary = resultSummary(marks, cutoff)
% resultSummary  Validates marks and builds the statistics for the report
%   marks  - vector of raw marks (may contain invalid entries)
%   cutoff - pass mark (35 if not given)
% Returned struct fields:
%   accepted, rejected, total, mean, best, worst,
%   passes, fails, passRate, grades (A/B/C/F counts), verdict

if nargin < 2
    cutoff = 35;
end

summary.accepted = [];
summary.rejected = [];

% validation: finite values in 0..100 only
for k = 1:numel(marks)
    value = marks(k);
    if isfinite(value) && value >= 0 && value <= 100
        summary.accepted(end+1) = value;
    else
        summary.rejected(end+1) = value;
    end
end

summary.total = 0; summary.mean = 0;
summary.best = 0;  summary.worst = 0;
summary.passes = 0; summary.fails = 0; summary.passRate = 0;
summary.grades = [0 0 0 0];               % counts of A, B, C, F

if isempty(summary.accepted)
    summary.verdict = 'NO RESULT - no valid marks found';
    return;
end

summary.best = summary.accepted(1);
summary.worst = summary.accepted(1);
for k = 1:numel(summary.accepted)
    value = summary.accepted(k);
    summary.total = summary.total + value;
    if value > summary.best
        summary.best = value;
    end
    if value < summary.worst
        summary.worst = value;
    end

    if value >= cutoff
        summary.passes = summary.passes + 1;
    else
        summary.fails = summary.fails + 1;
    end

    % grade bands: A >= 80, B >= 60, C >= cutoff, F below cutoff
    if value >= 80
        summary.grades(1) = summary.grades(1) + 1;
    elseif value >= 60
        summary.grades(2) = summary.grades(2) + 1;
    elseif value >= cutoff
        summary.grades(3) = summary.grades(3) + 1;
    else
        summary.grades(4) = summary.grades(4) + 1;
    end
end

summary.mean = summary.total / numel(summary.accepted);
summary.passRate = summary.passes / numel(summary.accepted) * 100;

if summary.passRate >= 80
    summary.verdict = 'EXCELLENT - at least 80% passed';
elseif summary.passRate >= 60
    summary.verdict = 'SATISFACTORY - 60% to 80% passed';
else
    summary.verdict = 'NEEDS IMPROVEMENT - under 60% passed';
end
end

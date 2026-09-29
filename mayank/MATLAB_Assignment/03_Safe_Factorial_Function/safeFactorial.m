function [fact, ok] = safeFactorial(n)
% safeFactorial  Factorial of a non-negative integer using a while loop
%   ok   = true when n is valid, false otherwise
%   fact = n! for valid input, NaN for rejected input

fact = NaN;
ok = false;

% reject non-numeric, non-scalar, negative or fractional input
if ~isnumeric(n) || ~isscalar(n) || n < 0 || n ~= floor(n)
    return;
end

ok = true;
fact = 1;
multiplier = n;
while multiplier > 1
    fact = fact * multiplier;
    multiplier = multiplier - 1;
end
end

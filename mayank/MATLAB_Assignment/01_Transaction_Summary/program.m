% Program 1: Mini Transaction Summary
% Input file : transactions.txt (one amount per line)
%   amount > 0  -> credit
%   amount < 0  -> debit
%   amount = 0  -> no change
% The formatted summary is written to output.txt
clc; clear;

ledgerFile  = 'transactions.txt';
summaryFile = 'output.txt';

ledgerId = fopen(ledgerFile, 'r');
if ledgerId == -1
    fprintf('Cannot open %s. Summary not created.\n', ledgerFile);
    return;
end
entries = fscanf(ledgerId, '%f');
fclose(ledgerId);

creditTotal = 0;  debitTotal = 0;
creditCount = 0;  debitCount = 0;  neutralCount = 0;
maxCredit = 0;    maxDebit = 0;
kinds = cell(length(entries), 1);

% classify each entry and update the running figures
for k = 1:length(entries)
    amount = entries(k);
    if amount > 0
        kinds{k} = 'CREDIT';
        creditTotal = creditTotal + amount;
        creditCount = creditCount + 1;
        if amount > maxCredit
            maxCredit = amount;
        end
    elseif amount < 0
        kinds{k} = 'DEBIT';
        debitTotal = debitTotal - amount;      % debit kept as a magnitude
        debitCount = debitCount + 1;
        if -amount > maxDebit
            maxDebit = -amount;
        end
    else
        kinds{k} = 'NO CHANGE';
        neutralCount = neutralCount + 1;
    end
end
netAmount = creditTotal - debitTotal;

outId = fopen(summaryFile, 'w');
if outId == -1
    error('Unable to write %s', summaryFile);
end
fprintf(outId, '------- MINI TRANSACTION SUMMARY -------\n');
fprintf(outId, 'Source file         : %s\n', ledgerFile);
fprintf(outId, 'Entries processed   : %d\n\n', length(entries));
fprintf(outId, '%-5s %12s   %s\n', 'Txn', 'Amount', 'Category');
for k = 1:length(entries)
    fprintf(outId, '%-5d %12.2f   %s\n', k, entries(k), kinds{k});
end
fprintf(outId, '\n');
fprintf(outId, 'Credit transactions : %d\n', creditCount);
fprintf(outId, 'Debit transactions  : %d\n', debitCount);
fprintf(outId, 'No-change entries   : %d\n', neutralCount);
fprintf(outId, 'Total credited      : %.2f\n', creditTotal);
fprintf(outId, 'Total debited       : %.2f\n', debitTotal);
fprintf(outId, 'Net balance         : %.2f\n', netAmount);
fprintf(outId, 'Largest credit      : %.2f\n', maxCredit);
fprintf(outId, 'Largest debit (mag) : %.2f\n', maxDebit);
fclose(outId);

type(summaryFile);

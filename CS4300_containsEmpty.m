function empty = CS4300_containsEmpty(resolvents)
% CS4300_RTP - resolution theorem prover
% On input:
%     resolvents: the list of clauses
% On output:
%     empty: result of checking if an empty clause exists
% Call:  (example from Russell & Norvig, p. 252)
%     resolvents(1).clauses = [-1,2,3,4];
%     resolvents(2).clauses = [-2];
%     resolvents(3).clauses = [-3];
%     resolvents(4).clauses = [1];
%     Sr = CS4300_containsEmpty(resolvents);
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%

empty = false;

for i = 1:length(resolvents)
    if(length(resolvents(i).clauses) == 0)
        empty = true;
    end
end
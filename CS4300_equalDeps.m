function resolved = CS4300_equalDeps(resolvents)
% CS4300_RTP - resolution theorem prover
% On input:
%     resolvents: the list of clauses just resolved
% On output:
%     resolved: the list of clauses updated to remove duplicates
% Call:  (example from Russell & Norvig, p. 252)
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     thm = [4];
%     vars = [1,2,3,4];
%     Sr = CS4300_resolve(DP,thm);
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%

resolved = resolvents;
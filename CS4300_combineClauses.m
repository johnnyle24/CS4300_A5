function combinedClauses = CS4300_combineClauses(current, new)
% CS4300_RTP - resolution theorem prover
% On input:
%     new: the list of clauses that were just resolved
%     clauses: the current list of clauses
% On output:
%     combinedClauses: result of checking if every clause in new is in
%     clauses and adding the new ones
% Call:  (example from Russell & Norvig, p. 252)
%     current(1).clauses = [-1,2,3,4];
%     current(2).clauses = [-2];
%     current(3).clauses = [-3];
%     current(4).clauses = [1];
%     new(1).clauses = [5,6];
%     CC = CS4300_combineClauses(current,new);
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%

combinedClauses = [];
ccIndex = 1;
found = false;
equal = true;

for l = 1:length(current)
    combinedClauses(ccIndex).clauses = current(l).clauses;
    ccIndex = ccIndex + 1;
end

for i = 1:length(new)
   for j = 1:length(combinedClauses)
       equal = true;
       found = true;
       for k = 1:length(combinedClauses(j).clauses)
           if(k > length(combinedClauses(j).clauses) || k > length(new(i).clauses) || new(i).clauses(k) ~= combinedClauses(j).clauses(k))
               equal = false;
               break;
           end
       end
       if (~equal)
          found = false;
       else
          found = true;
          break;
       end
   end
   
   if(~found)
        c3 = new(i).clauses;
        combinedClauses(ccIndex).clauses = new(i).clauses;
        ccIndex = ccIndex + 1;
   end
end



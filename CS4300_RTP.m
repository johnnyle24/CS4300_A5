function Sip = CS4300_RTP(KB,thm,vars)
% CS4300_RTP - resolution theorem
% On input:
%     KB: knowledge base, a sentence in propositional logic
%     a: query, a sentence in propositional logic
% On output:
%     resolution: results of resolution
%        []: proved sentence |- thm
%        not []: thm does not follow from sentences
% Call:  (example from Russell & Norvig, p. 252)
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     thm(1).clauses = [4];
%     vars = [1,2,3,4];
%     resolution = CS4300_resolve(C1, C2);
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%


clauses = []; % The set of clauses in the CNF rep of KB ^ ~a

clauseIndex = 1;

for thmInd = 1:length(thm)
    negThm(thmInd).clauses = -1 * thm(thmInd).clauses;
end
    

for kbIndex = 1:length(KB)
    clauses(kbIndex).clauses = KB(kbIndex).clauses;
    clauseIndex = clauseIndex + 1;
end

for thmIndex = 1:length(negThm)
    clauses(clauseIndex).clauses = negThm(thmIndex).clauses;
    clauseIndex = clauseIndex + 1;
end
        

new = [];

resolvents = [];

Sip = [];

while(1)
    
    for i = 1:length(clauses)

        for j = 1:length(clauses)

            c1 = clauses(i).clauses;
            c2 = clauses(j).clauses;
            resolvents = CS4300_resolve(c1, c2);

            if (CS4300_containsEmpty(resolvents)) % check if one of resolvent's clauses is empty
                Sip = [];
                return;
            end

            new = CS4300_combineClauses(new, resolvents); % Add any new clauses to new

        end

    end
    
    %if (CS4300_subset(new, clauses)) % check if all of new's clauses are in clauses
     %   resolution = thm;
     %   break;
    %end
    
    temp = clauses;
    clauses = CS4300_combineClauses(clauses, new); % add all of the new clauses to clauses
    
    if(length(temp) == length(clauses))
       Sip = clauses;
       break
    end 
end


        
        
        
        
        






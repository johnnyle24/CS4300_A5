function resolvents = CS4300_resolve(C1,C2)
% CS4300_resolve - outputs the possible clauses from the two clauses given
% On input:
%     C1: First input clause
%     C2: Second input clause
% On output:
%     resolvents (CNF data structure): all possible clauses as a result of
%     resolving the two inputs
% Call:  (example from Russell & Norvig, p. 252)
%     c1 = [1]
%     c2 = [-1,2]
%     resolvents = CS4300_resolve(c1,c2);
%     resolvents = 2
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%

resolvents = [];

numResolvents = 0;

for i = 1:length(C1)
    
    for j = 1:length(C2)
        if (C1(i) == -C2(j))
            R = [C1(1:i-1), C1(i+1:end), C2(i:j-1), C2(j+1:end)];
            
            numResolvents = numResolvents + 1;
            
            resolvents(numResolvents).clauses = R;
        end
        
    end
    
end





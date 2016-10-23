function result = CS4300_Tell(KB, percept_sentence)
% CS4300_Tell - Adds percept sentence to knowledge base
% On input:
%     sentences (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     percept_sentence: 1 disjunctive clause to be added
% On output:
%       returns the update KB
% Call:
%     CS4300_tell(kb, [-1,2]);
% Author:
%     Trung Le and Johnny Le
%     UU
%     Fall 2016
%

num_clauses = length(KB);
num_clauses = num_clauses + 1;
temp_num = num_clauses;
result = KB;
temp = result;
dup = 0;

for i = 1:length(percept_sentence)

    for j = 1:length(result)
       if(result(j).clauses == percept_sentence(i).clauses)
           dup = 1;
           break;
       end
    end
    
    if(~dup)
        %result(num_clauses).clauses = percept_sentence(i).clauses;
        %num_clauses = num_clauses + 1;
        
        temp(temp_num).clauses = percept_sentence(i).clauses;
        temp_num = temp_num + 1;
    end
    
    %check for consistency
    
    sen(1).clauses = 1;
    if(CS4300_Ask(temp,sen))
        %do nothing
    else
        result = temp;
        result(1).vars = [result(1).vars,percept_sentence(i).clauses];
        result(1).vars = unique(result(1).vars);
    end
    
    
    
    
end



%TODO: Check for duplicates


end


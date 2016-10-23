function result = CS4300_Ask(KB, sentence)
% CS4300_Ask - checks percept_sentence against KB and returns true or false
% On input:
%     sentences (CNF data structure): array of conjunctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     percept_sentence: 1 disjunctive clause to be added
% Call:
%     CS4300_Ask(kb, [-1,2]);
% Author:
%     Trung Le and Johnny Le
%     UU
%     Fall 2016
%

% vars not used by our rtp

vars = [1];
s = size(KB(1).vars);
for i = 1:s(2)
    temp = KB(1).vars;
    vars = [vars abs(temp(i))]; 
end

vars = unique(vars);


rtp_result = CS4300_RTP2(KB,sentence,vars);

if(length(rtp_result) == 0)
    result = 1; 
else
    result = 0;
end

end


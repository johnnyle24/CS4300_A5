function result = CS4300_Convert_Imply_To_CNF(c1, c2)
%{ 
 CS4300_Convert_Imply_To_CNF - convert c1 implies c2 to CNF
   Abstract:
    b11 -> (p12 V p21) = (-b11 V p12 V p21) A (-p12 V b11) ^ (p21 V b11)
    c1 = 17
    c2 = [2,5]
    result(1) = [-17,5,2]
    result(2) = [-5,17]
    result(3) = [-2,17]
   
 On input:
     percept_sentence: 1 disjunctive clause to be added
 Call:
     res = CS4300_Convert_Imply_To_CNF(17,[5,2])
 Author:
     Trung Le and Johnny Le
     UU
     Fall 2016

%}


len = length(c2) + 1;

switch len
    case 3
        result(1).clauses = [-c1,c2(1),c2(2)];
        result(2).clauses = [-c2(1),c1];
        result(3).clauses = [-c2(2),c1];
    case 4
        result(1).clauses = [-c1,c2(1),c2(2),c2(3)];
        result(2).clauses = [-c2(1),c1];
        result(3).clauses = [-c2(2),c1];
        result(4).clauses = [-c2(3),c1];
    case 5
        result(1).clauses = [-c1,c2(1),c2(2),c2(3),c2(4)];
        result(2).clauses = [-c2(1),c1];
        result(3).clauses = [-c2(2),c1];
        result(4).clauses = [-c2(3),c1];
        result(5).clauses = [-c2(4),c1];
end
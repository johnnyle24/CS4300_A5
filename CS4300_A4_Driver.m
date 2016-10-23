function results = CS4300_A4_Driver()
% CS4300_4300_A4_Driver : the driver
% On output:
%     empty: result of checking the resolution
% Author:
%     Johnny Le and Trung Le
%     UU
%     Fall 2016
%


     DP(1).clauses = [-1,2,3,4];
     DP(2).clauses = [1,2];
     DP(3).clauses = [3];
     DP(4).clauses = [4];
     thm(1).clauses = [3];
     thm(2).clauses = [4];
     %DP(1).clauses = [1];
     %DP(2).clauses = [-1,2];
     %thm(1).clauses = [3];
     vars = [1,2,3,4];
     resolution = CS4300_RTP(DP, thm, vars)
     
     res = CS4300_Ask(DP, thm)
     disp('Done');
end
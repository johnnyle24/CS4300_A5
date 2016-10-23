function sentence = CS4300_Make_Percept_Sentence(percept,x,y)
%Tell the knowledge base what the agent perceives
%Simply add percept to knowledge base?
%not used in psuedo code it seems?


% convert percept into a sentence

%      (1): Stench
%      (2): Breeze
%      (3): Glitters
%      (4): Bumped
%      (5): Screamed
%Type
%0 Pits
%1 Breeze
%2 Stench
%3 Wumpus
%4 Glitter


if(percept(1))
   stench = CS4300_Get_Index(x,y,1,2);
else
   stench = CS4300_Get_Index(x,y,-1,2);
end


if(percept(2))
   breeze = CS4300_Get_Index(x,y,1,1);
else
   breeze = CS4300_Get_Index(x,y,-1,1);
end

if(percept(3))
   glitter = CS4300_Get_Index(x,y,1,4);
else
   glitter = CS4300_Get_Index(x,y,-1,4);
end


sentence(1).clauses = stench; 
sentence(2).clauses = breeze; 
sentence(3).clauses = glitter;

%not used bumped and screamed
%sentence(4).clauses = percept(4);
%sentence(5).clauses = percept(5);


end


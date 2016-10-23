function index = CS4300_Get_Index(x,y,negation,type)
%Given x, y return the stench index
%Pits [1,16]
%Breeze [17,32]
%Stench [33,48]
%Wumpus [49,65]
%Gold [66, 81]

%Type
%0 Pits
%1 Breeze
%2 Stench
%3 Wumpus
%4 Gold

%negation = 1 or -1

index = ((4 * (y-1) + x) + (16 * type)) * negation;


end
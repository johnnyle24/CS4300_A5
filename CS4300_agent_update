function agent = CS4300_agent_update(agent,action)
%action (int): action to take
%       1: FORWARD
%       2: RIGHT
%       3: LEFT
%       4: GRAB
%       5: SHOOT
%       6: CLIMB

switch action
    case 1
        switch agent.dir 
            case 0
                if(agent.x <= 4)
                    agent.x = agent.x + 1;
            case 1
                if(agent.y <= 4)
                    agent.y = agent.y + 1;
            case 2
                if(agent.x >= 1)
                    agent.x = agent.x - 1;
            case 3
                if(agent.x >= 1)
                    agent.y = agent.y - 1;
    case 2
        switch agent.dir
            case 0
                agent.dir = 3;
            case 1
                agent.dir = 0;
            case 2
                agent.dir = 1;
            case 3
                agent.dir = 2;
    case 3
        switch agent.dir
            case 0
                agent.dir = 1;
            case 1
                agent.dir = 2;
            case 2
                agent.dir = 3;
            case 3
                agent.dir = 0;

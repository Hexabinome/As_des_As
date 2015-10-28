% Implementation of an A.I. internally relying on other A.I., given
% a previously defined propability.
%. E.g. for each action-triple choosing an aggresive choice at 42
% percent while choosing a defensive option at 58 percent.
% [Maxou]

strategyA(Idx) :- aiDefensive(Idx).
strategyB(Idx) :- aiOffensive(Idx).

% pick float between 0 an 1 to specify aggressiveness. 1 is entirely offensive, 0 is entirely defensive.
aiProbab(Idx, Aggressiveness) :- random(C), chooseStrat(Idx, C, Aggressiveness).
chooseStrat(Idx, C, Aggressiveness) :- C > Aggressiveness, !, strategyA(Idx).
chooseStrat(Idx, C, Aggressiveness) :- C =< Aggressiveness, !, strategyB(Idx).
 

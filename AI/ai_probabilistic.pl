<<<<<<< HEAD
% [Maxou]
% This file containes the predicates for two AIs:
%
% [1] => aiProbab is the implementation of an A.I. internally relying on other A.I., given
% a previously defined static propability.
=======
:- module(ai_probabilistic, [aiProbab/2]).

:- use_module('ai_general').
:- use_module('ai_offensive').
:- use_module('ai_defensive').
:- use_module('../Game/plane').
:- use_module('../Game/plane_actions').

% Implementation of an A.I. internally relying on other A.I., given
% a previously defined propability.
>>>>>>> 67e8c6db685eead281fa00eea829b86e2a809e31
%. E.g. for each action-triple choosing an aggresive choice at 42
% percent while choosing a defensive option at 58 percent.
%
% [2] => aiMechante internally uses aiProbab. It behaves cowardly and mean. This is to say 
% it changes its internal probability of performing aggressive moves.
% If about to win (more HP than the other AI) it augments the probability to perform aggressive moves.
% If about to lose (less HP that the other AI) it reduces the probability to perform aggressive moves.
% See table below:
% If two HP less then enemy:
% diff == -2 -> entirely defensive (Aggressiveness = 0.0)
% If one HP less then enemy:
% diff == -1 -> rather defensive (Aggressiveness = 0.25)
% If same amount HP as enemy:
% diff == 0 -> aggressive and defensive moves have same probabillity (Aggressiveness = 0.5)
% If one HP more then enemy:
% diff == +1 -> rather aggressive (Aggressiveness = 0.75)
% If two HP more then enemy:
% diff == +2 -> entirely aggressive (Aggressiveness = 1.0)

% [1] pick static float between 0 an 1 to specify aggressiveness. 1 is entirely offensive, 0 is entirely defensive.
aiProbab(Idx, Aggressiveness) :- random(C), chooseStrat(Idx, C, Aggressiveness).
<<<<<<< HEAD
chooseStrat(Idx, C, Aggressiveness) :- C > Aggressiveness, !, aiDefensive(Idx).
chooseStrat(Idx, C, Aggressiveness) :- C =< Aggressiveness, !, aiOffensive(Idx).

% [2] use dynamic float based on HP diffence to enemy to calculate aggressiveness.
aiMechante(Idx) :- mechantite(Idx, Aggressiveness), aiProbab(Idx, Aggressiveness).

% calculates the level of aggressiveness given the current advantege / disadvantage
% if about to win the ai becomes more aggressive, if it is about to lose it is rather defensive.
mechantite(1, Aggressiveness) :- plane(1, _, _, Hp1, _), plane(2, _, _, Hp2, _), Aggressiveness is (Hp1-Hp2+2)/4.
mechantite(2, Aggressiveness) :- plane(2, _, _, Hp1, _), plane(1, _, _, Hp2, _), Aggressiveness is (Hp1-Hp2+2)/4. 
=======
chooseStrat(Idx, C, Aggressiveness) :- C > Aggressiveness, !, strategyA(Idx).
chooseStrat(Idx, C, Aggressiveness) :- C =< Aggressiveness, !, strategyB(Idx).
 
>>>>>>> 67e8c6db685eead281fa00eea829b86e2a809e31

:- dynamic actions/2.
:- dynamic round/1.

% Load files
:- [plane].
:- [board].
:- [human_player].
:- [ai_random].
:- [ai_offensive].

% Action structures that are used by human player and ai to store their moves
actions(1, []).
actions(2, []).

% Round counter
round(0).

% Game loop
step :-
	% ((round(X), X == 3, trace) ; true),
	aiOffensive(1),
	actions(1, ActionsP1),
	aiOffensive(2),
	actions(2, ActionsP2),
	displayMoves(ActionsP1, ActionsP2),
	updatePlanes(ActionsP1, ActionsP2),
	not(gameoverRound),
	playerDisplay(1),
	displayBoard,
	playerDisplay(2),
	pressToContinue,
	game.

%game :- gameover, !.
game :- incrementRoundCounter, roundDisplay, step.

% Increment the round counter
incrementRoundCounter :-
	round(X), 
	retract(round(X)), 
	Y is X+1, 
	assert(round(Y)).

% If InIdx == 1, OutIdx == 2, else if InIdx == 2, OutIdx == 1
otherPlayer(InIdx, OutIdx) :- InIdx == 1, OutIdx is 2, !.
otherPlayer(InIdx, OutIdx) :- InIdx == 2, OutIdx is 1, !.
								
pressToContinue :- 	write('** Write any character + "." to go to the next step. **'), nl,
					read(_).
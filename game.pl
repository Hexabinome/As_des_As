:- dynamic actions/2.
:- dynamic round/1.

% Load files
:- [plane].
:- [board].
:- [human_player].
:- [ia_random].

% Action structures that are used by human player and ai to store their moves
actions(1, []).
actions(2, []).

% Round counter
round(0).

% Game loop
step :-
	aiRandom(1),
	actions(1, ActionsP1),
	aiRandom(2),
	actions(2, ActionsP2),
	updatePlanes(ActionsP1, ActionsP2),
	displayMoves(ActionsP1, ActionsP2),
	not(gameoverRound),
	playerDisplay(1),
	displayBoard,
	playerDisplay(2),
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
otherPlayer(InIdx, OutIdx) :- 	plane(InIdx, _, _, _, _),
								plane(OutIdx, _, _, _, _),
								InIdx \== OutIdx.
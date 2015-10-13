:- dynamic actions/2.
:- dynamic round/1.

:- discontiguous gameover/0.

% Load files
:- [plane].
:- [board].
:- [human_player].

% Action structures that are used by human player and ai to store their moves
actions(1, []).
actions(2, []).

% Round counter
round(0).

% --- Draw possibilities
% If boths have lifePoints equal to 0.
gameover :- gameoverDeath.
gameoverDeath :- plane(1, _, _, Life1, _), plane(2, _, _, Life2, _), Life1 =< 0, Life1 == Life2, drawDisplay, !.
% If collision : both are at the same coordinates.
gameover :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, drawDisplay, !.
% If they  both are out of boundaries at the end of the turn
gameover :- gameoverOutOfBoundary(1), gameoverOutOfBoundary(2), drawDisplay, !.

% --- One winning side gameover
% Gameover if one has no life left
gameover :- gameoverDeath(1), playerTwoWinsDisplay, !.
gameover :- gameoverDeath(2), playerOneWinsDisplay, !.
gameoverDeath(Idx) :- plane(Idx, _, _, Life, _), Life =< 0.
% Gameover if one is out of the board
gameover :- gameoverOutOfBoundary(1).
gameover :- gameoverOutOfBoundary(2).

% Limit number of 200 rounds reached
gameover :- round(200), drawDisplay, !.

% Gameover tests if plane is out of boundaries
gameoverOutOfBoundary(Idx) :- plane(Idx, X, _, _, _), X < 0, !.
gameoverOutOfBoundary(Idx) :- plane(Idx, X, _, _, _), X > 15, !.
gameoverOutOfBoundary(Idx) :- plane(Idx, _, Y, _, _), Y < 0, !.
gameoverOutOfBoundary(Idx) :- plane(Idx, _, Y, _, _), Y > 15, !.


step :-
	humanPlayer(1),
	actions(1, ActionsP1),
	% aiRandom(2),
	% actions(2, ActionsP2),
	% updatePlanes(ActionsP1, ActionsP2),
	updatePlanes(ActionsP1, ['F', 'F', 'F']),
	playerDisplay(1),
	displayBoard,
	playerDisplay(2),
	game.

game :- gameover, !.
game :- incrementRoundCounter, roundDisplay, step.

% Increment the round counter
incrementRoundCounter :-
	round(X), 
	retract(round(X)), 
	Y is X+1, 
	assert(round(Y)).

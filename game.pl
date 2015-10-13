:- dynamic actions/2.

% Load files
:- [plane].
:- [board].
:- [human_player].

actions(1, []).
actions(2, []).

% reset:-retract(avion1(_,_,0)).
% reset:-retract(avion2(_,_,0)).

% DRAW POSSIBILITIES 
% If boths have lifePoints equal to 0.
gameover :- plane(1, _, _, Life1, _), plane(2, _, _, Life2, _), Life1 == 0, Life1 == Life2, drawDisplay, !.
% If collision : both are at the same coordinates.
gameover :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, drawDisplay, !.
% If they  both are out of boundaries at the end of the turn
gameover :- gameoverOutOfBoundary(1), gameoverOutOfBoundary(2), drawDisplay, !.

% Gameover if one has no life left
gameover :- plane(1, _, _, Life, _), Life =< 0, playerTwoWinsDisplay, !.
gameover :- plane(2, _, _, Life, _), Life =< 0, playerOneWinsDisplay, !.
% Gameover if one is out of the board
gameover :- gameoverOutOfBoundary(1), playerTwoWinsDisplay, !.
gameover :- gameoverOutOfBoundary(2), playerOneWinsDisplay, !.

% TODO : gameover :- round > 200, drawDisplay.

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
	displayBoard,
	game.

game :- gameover, !.
game :- step.

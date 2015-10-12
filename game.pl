% Load files
:- [plane].
:- [board].

% reset:-retract(avion1(_,_,0)).
% reset:-retract(avion2(_,_,0)).

% Draw possibilities
gameover :- plane(1, _, _, Life1, _), plane(2, _, _, Life2, _), Life1 == 0, Life1 == Life2, drawDisplay, !.
gameover :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, drawDisplay, !.

% Gameover if one has no life left
gameover :- plane(1, _, _, Life, _), Life =< 0, playerTwoWinsDisplay, !.
gameover :- plane(2, _, _, Life, _), Life =< 0, playerOneWinsDisplay, !.
% Gameover if one is out of the board
gameover :- gameoverOutOfRange(1), playerTwoWinsDisplay, !.
gameover :- gameoverOutOfRange(2), playerOneWinsDisplay, !.

% TODO : gameover :- round > 200, drawDisplay.


gameoverOutOfRange(Idx) :- plane(Idx, X, _, _, _), X < 0, !.
gameoverOutOfRange(Idx) :- plane(Idx, X, _, _, _), X > 15, !.
gameoverOutOfRange(Idx) :- plane(Idx, _, Y, _, _), Y < 0, !.
gameoverOutOfRange(Idx) :- plane(Idx, _, Y, _, _), Y > 15, !.


step :-
	updatePlanes(['FF', 'LT', 'UT'], ['LT', 'RT', 'F']), % test values, a supprimer
	displayBoard.
	%,game(). % a décommenter pour boucle de jeu

game :- gameover, !.
game :- step.

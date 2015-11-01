:- module(display, [display/1,
							playerWinDisplay/1,
							drawDisplay/0,
							roundDisplay/0,
							playerDisplay/1,
							shotDisplay/2,
							displayMoves/2,
							displayActions/1,
							outOfBoundaryDisplay/1,
							deathDisplay/1,
							collisionDisplay/0,
							roundLimitDisplay/0]).

:- use_module('Game/plane').

% Stop condition for displaying the board
display([]).
% Displays each row, and then displays the rest of the board by recursion.
display([Row|B]) :- displayRow(Row), display(B).

% Ends a row display (if row is empty)
displayRow([]) :- nl.
% Displays one element of the row and calls recursively for the rest of the row.
displayRow([Element|Row]) :- write(Element), write('|'), displayRow(Row).

% Gameover displays
playerWinDisplay(Idx) :- write('Player '), write(Idx), write(' wins!'), nl.
drawDisplay :- write('Draw!'), nl.

% Game status display
roundDisplay :- write('Round : '), round(NB), write(NB), nl.
playerDisplay(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
						write('--- Player '), write(Idx), write(' ---'), nl,
						write('Remaining life : '), write(Life), nl,
						write('Position : X:'), write(X), write(' Y:'), write(Y), write('. Orientation:'), write(Orientation), nl.

shotDisplay(SrcIdx, DestIdx) :- write('Player '),
								write(SrcIdx),
								write(' shot at player '),
								write(DestIdx),
								write('!'),
								nl.
displayMoves(ActionsP1, ActionsP2) :- displayPlayerMoves(1, ActionsP1), displayPlayerMoves(2, ActionsP2).
displayPlayerMoves(Idx, Actions) :- write('Moves P'), write(Idx), write(' : ['), displayActions(Actions), write('].'), nl.
displayActions([]).
displayActions([FirstAction|Rest]) :- write(FirstAction), write(', '), displayActions(Rest).


% Gameover reasons display
outOfBoundaryDisplay(Idx) :- write('Player '), write(Idx), write(' out of board.'), nl.
deathDisplay(Idx) :- write('Player '), write(Idx), write(' has been killed!'), nl.
collisionDisplay :- write('Both players are at the same coordinates. Collision!'), nl.
roundLimitDisplay :- write('The round limit has been reached'), nl.

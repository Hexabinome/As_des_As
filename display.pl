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
						
% Gameover reasons display
outOfBoundaryDisplay(Idx) :- write('Player '), write(Idx), write(' out of board.'), nl.
deathDisplay(Idx) :- write('Player '), write(Idx), write(' has been killed!'), nl.
collisionDisplay :- write('Both players are at the same coordinates. Collision!'), nl.
roundLimitDisplay :- write('The round limit has been reached'), nl.

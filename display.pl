% Stop condition for displaying the board
display([]).
% Displays each row, and then displays the rest of the board by recursion.
display([Row|B]) :- displayRow(Row), display(B).

% Ends a row display (if row is empty)
displayRow([]) :- print('\n').
% Displays one element of the row and calls recursively for the rest of the row.
displayRow([Element|Row]) :- print(Element), print('|'), displayRow(Row).


% Test call : display([[a,b,c],[c,d,e],[f,g,i]]).


% Gameover displays
playerOneWinsDisplay :- print('Player 1 wins!').
playerTwoWinsDisplay :- print('Player 2 wins!').
drawDisplay :- print('Draw!').
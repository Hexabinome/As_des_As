:- [display].

%% le terrain de jeu 16 *16
defaultBoard([ [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.]]
        ).

		
%% remplace un element à un index I donné dans une liste
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).

replaceBoard(X, Y, Value, Board, Result):-
			nth0(X, Board, E),
			replace(E, X, Value, M),
			replace(Board, Y, M, Result).
			
displayBoard :- 
			defaultBoard(Board),
			plane(1, C1x, C1y, _, Orientation1),
			replaceBoard(C1x, C1y, Orientation1, Board, BoardSortie),
			plane(2, C2x, C2y, _, Orientation2),
			replaceBoard(C2x, C2y, Orientation2, BoardSortie, BoardFinal),
			display(BoardFinal).

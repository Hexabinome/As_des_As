:- dynamic board/1.
:- [display].

%% le terrain de jeu 16 *16
defaultBoard([ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]]
        ).

		
%% remplace un element à un index I donné dans une liste
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).

replaceBoard(X, Y, Value, Board, Result):-
			nth0(X, Board, E),
			replace(E, X, Value, M),
			replace(Board, Y, M, Result).
displayBoard :- 
			defaultBoard(B),
			plane(1, C1x, C1y,_,O1),
			replaceBoard(C1x,C1y,O1,B,X),
			plane(2, C2x, C2y,_,O2),
			replaceBoard(C2x,C2y,O2,X,D),
			display(D).

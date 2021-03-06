﻿:- module(board, [defaultBoard/1,
							replace/4,
							replaceBoard/5,
							displayBoard/0]).

:- use_module('../display').
:- use_module('plane').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% le terrain de jeu 16 *16
defaultBoard([ 
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
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.],
        [.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.]]
        ).

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
%% remplace un element à un index I donné dans une liste
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).

% genere une vue du plateau de jeu à partir du plateau de base (vide)
% et de la position des avions
replaceBoard(X, Y, Value, Board, Result):-
			nth0(X, Board, E),
			replace(E, X, Value, M),
			replace(Board, Y, M, Result).
			
%affiche le plateau de jeu
displayBoard :- 
			defaultBoard(Board),
			plane(1, C1x, C1y, _, Orientation1),
			string_concat(1, Orientation1, OutPlane1),
			replaceBoard(C1x, C1y, OutPlane1, Board, BoardSortie),
			plane(2, C2x, C2y, _, Orientation2),
			string_concat(2, Orientation2, OutPlane2),
			replaceBoard(C2x, C2y, OutPlane2, BoardSortie, BoardFinal),
			display(BoardFinal).

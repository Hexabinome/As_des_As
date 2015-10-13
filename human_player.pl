humanPlayer(Idx) :-	displayListOfMoves,
					retract(actions(Idx, _)),
					
					write('First move : '),
					read(Move1),
					
					write('Second move : '),
					read(Move2),
					
					write('Third move : '),
					read(Move3),
					
					assert(actions(Idx, [Move1, Move2, Move3])).
						
displayListOfMoves :- write('Moves : F, FF, RT, LT, UT'), nl.

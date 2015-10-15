% Implementation of an A.I. doing random moves (under the premise that the selected
% move does not lead the plane out of bounds).
% [Maxou]

% Possible movements as FACTS.
moves(['F', 'FF', 'RT', 'LT', 'UT']).

% The three cannot be computed all at once, for each move influences the
% following possibilities. Therefore the temporary position must be updated 
% between the indivual move-choices. (This is covered by the randomMove 
% predicates)
aiRandom(Idx) :- retract(actions(Idx, _)),
		initTempPos(Idx),
		print(Idx), print(':'),
		randomMove(Move1),
		randomMove(Move2),
		randomMove(Move3),
		nl,
		retract(tempPos(_,_,_)),
		assert(actions(Idx, [Move1, Move2, Move3])).
			
% Initially update the temporary position and orientation to the planes' values.
initTempPos(Idx) :- plane(Idx, X, Y, _, O), assert(tempPos(X, Y, O)).

% Updates the planes temporary position given a certain action.
updateTempPos(Act) :- tempPos(OldX, OldY, OldO), newPos(NewX, NewY, NewO, Act), retract(tempPos(OldX, OldY, OldO)), assert(tempPos(NewX, NewY, NewO)).

% USAGE: Returns R as a randomly chosen movement for a plane specified by index.
randomMove(R) :- filter(F), random_member(R, F), updateTempPos(R), print(R), print('.').
 
% Returns list F of all valid movements for a plane secified by index.
% The criteria used to determine which option are valid and which are invalid is:
% 'filterConditionX'.
filter(F) :- moves(M), include(filterCondition, M, F).%, print(F), print( -> ).

% Use 'plane remains within bounds' as filter condition. (Stays in list ic condition is met).
filterCondition(Option) :- newPos(NewX, NewY, _, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.

% Calculates a planes new position (presuming a certain movement) without actually
% changing the position stocked in the DB. 
newPos(NewX, NewY, NewO, 'F')  :- tempPos(OldX, OldY, 'N'), NewX is OldX, NewY is OldY-1, NewO = 'N'.
newPos(NewX, NewY, NewO, 'F')  :- tempPos(OldX, OldY, 'E'), NewX is OldX+1, NewY is OldY, NewO = 'E'.
newPos(NewX, NewY, NewO, 'F')  :- tempPos(OldX, OldY, 'S'), NewX is OldX, NewY is OldY+1, NewO = 'S'.
newPos(NewX, NewY, NewO, 'F')  :- tempPos(OldX, OldY, 'W'), NewX is OldX-1, NewY is OldY, NewO = 'W'.
newPos(NewX, NewY, NewO, 'FF') :- tempPos(OldX, OldY, 'N'), NewX is OldX, NewY is OldY-2, NewO = 'N'.
newPos(NewX, NewY, NewO, 'FF') :- tempPos(OldX, OldY, 'E'), NewX is OldX+2, NewY is OldY, NewO = 'E'.
newPos(NewX, NewY, NewO, 'FF') :- tempPos(OldX, OldY, 'S'), NewX is OldX, NewY is OldY+2, NewO = 'S'.
newPos(NewX, NewY, NewO, 'FF') :- tempPos(OldX, OldY, 'W'), NewX is OldX-2, NewY is OldY, NewO = 'W'.
newPos(NewX, NewY, NewO, 'RT') :- tempPos(OldX, OldY, 'N'), NewX is OldX+1, NewY is OldY-1, NewO = 'E'.
newPos(NewX, NewY, NewO, 'RT') :- tempPos(OldX, OldY, 'E'), NewX is OldX+1, NewY is OldY+1, NewO = 'S'.
newPos(NewX, NewY, NewO, 'RT') :- tempPos(OldX, OldY, 'S'), NewX is OldX-1, NewY is OldY+1, NewO = 'W'.
newPos(NewX, NewY, NewO, 'RT') :- tempPos(OldX, OldY, 'W'), NewX is OldX-1, NewY is OldY-1, NewO = 'N'.
newPos(NewX, NewY, NewO, 'LT') :- tempPos(OldX, OldY, 'N'), NewX is OldX-1, NewY is OldY-1, NewO = 'W'.
newPos(NewX, NewY, NewO, 'LT') :- tempPos(OldX, OldY, 'E'), NewX is OldX+1, NewY is OldY-1, NewO = 'N'.
newPos(NewX, NewY, NewO, 'LT') :- tempPos(OldX, OldY, 'S'), NewX is OldX+1, NewY is OldY+1, NewO = 'E'.
newPos(NewX, NewY, NewO, 'LT') :- tempPos(OldX, OldY, 'W'), NewX is OldX-1, NewY is OldY+1, NewO = 'S'.
newPos(NewX, NewY, NewO, 'UT') :- tempPos(OldX, OldY, 'N'), NewX is OldX, NewY is OldY, NewO = 'S'.
newPos(NewX, NewY, NewO, 'UT') :- tempPos(OldX, OldY, 'E'), NewX is OldX, NewY is OldY, NewO = 'W'.
newPos(NewX, NewY, NewO, 'UT') :- tempPos(OldX, OldY, 'S'), NewX is OldX, NewY is OldY, NewO = 'N'.
newPos(NewX, NewY, NewO, 'UT') :- tempPos(OldX, OldY, 'W'), NewX is OldX, NewY is OldY, NewO = 'E'.


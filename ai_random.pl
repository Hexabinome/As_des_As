% Implementation of an A.I. doing random moves (under the prmise that the selected
% move does not lead the plane out of bounds).
% [Maxou]

%dummy plane test position an orientation for devs:
% TODO: Remove. (actual plane positions shall be used instead).
%(index, posX, posY, HP, orientation)
%plane(1, 0, 2, 3, 'S').
%plane(2, 15, 15, 3, 'E').

% Possible movements as FACTS.
moves(['F', 'FF', 'RT', 'LT', 'UT']).

aiRandom(Idx) :- retract(actions(Idx, _)),
					randomMove(Idx, Move1),
					randomMove(Idx, Move2),
					randomMove(Idx, Move3),
				assert(actions(Idx, [Move1, Move2, Move3])).

% USAGE: Returns R as a randomly chosen movement for a plane specified by index.
randomMove(Idx, R) :- filter(Idx, F), random_member(R, F), print(R).
 
% Returns list F of all valid movements for a plane secified by index.
% The criteria used to determine which option are valid and which are invalid is:
% 'filterConditionX'. Note: 1, 2  Needs to be hard coded here, for the filter uses
% swipl's 'include' API method which does not support passing the index as an 
% additional argument.
filter(1, F) :- moves(M), include(filterCondition1, M, F), print(F), print( -> ).
filter(2, F) :- moves(M), include(filterCondition2, M, F), print(F), print( -> ).

% Use 'plane remains within bounds' as filter condition. (Stays in list ic condition is met).
filterCondition1(Option) :- newPos(NewX, NewY, 1, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.
filterCondition2(Option) :- newPos(NewX, NewY, 2, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.

% Calculates a planes new position (presuming a certain movement) without actually
% changing the position stocked in the DB. 
newPos(NewX, NewY, Idx, 'F')  :- plane(Idx, X, Y, _, 'N'), NewX is X, NewY is Y-1.
newPos(NewX, NewY, Idx, 'F')  :- plane(Idx, X, Y, _, 'E'), NewX is X+1, NewY is Y.
newPos(NewX, NewY, Idx, 'F')  :- plane(Idx, X, Y, _, 'S'), NewX is X, NewY is Y+1.
newPos(NewX, NewY, Idx, 'F')  :- plane(Idx, X, Y, _, 'W'), NewX is X-1, NewY is Y.
newPos(NewX, NewY, Idx, 'FF') :- plane(Idx, X, Y, _, 'N'), NewX is X, NewY is Y-2.
newPos(NewX, NewY, Idx, 'FF') :- plane(Idx, X, Y, _, 'E'), NewX is X+2, NewY is Y.
newPos(NewX, NewY, Idx, 'FF') :- plane(Idx, X, Y, _, 'S'), NewX is X, NewY is Y+2.
newPos(NewX, NewY, Idx, 'FF') :- plane(Idx, X, Y, _, 'W'), NewX is X-2, NewY is Y.
newPos(NewX, NewY, Idx, 'RT') :- plane(Idx, X, Y, _, 'N'), NewX is X+1, NewY is Y-1.
newPos(NewX, NewY, Idx, 'RT') :- plane(Idx, X, Y, _, 'E'), NewX is X+1, NewY is Y+1.
newPos(NewX, NewY, Idx, 'RT') :- plane(Idx, X, Y, _, 'S'), NewX is X-1, NewY is Y+1.
newPos(NewX, NewY, Idx, 'RT') :- plane(Idx, X, Y, _, 'W'), NewX is X-1, NewY is Y-1.
newPos(NewX, NewY, Idx, 'LT') :- plane(Idx, X, Y, _, 'N'), NewX is X-1, NewY is Y-1.
newPos(NewX, NewY, Idx, 'LT') :- plane(Idx, X, Y, _, 'E'), NewX is X+1, NewY is Y-1.
newPos(NewX, NewY, Idx, 'LT') :- plane(Idx, X, Y, _, 'S'), NewX is X+1, NewY is Y+1.
newPos(NewX, NewY, Idx, 'LT') :- plane(Idx, X, Y, _, 'W'), NewX is X-1, NewY is Y+1.
newPos(NewX, NewY, Idx, 'UT') :- plane(Idx, X, Y, _, _),   NewX is X, NewY is Y.

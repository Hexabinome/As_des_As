% Implementation of an A.I. doing random moves (under the prmise that the selected
% move does not lead the plane out of bounds).
% [Maxou]

%[plane].

%dummy plane test position an orientation for devs:
%(index, posX, posY, HP, orientation)
plane(1, 0, 2, 3, 'S').
plane(2, 4, 15, 3, 'E').

% Possible movements as FACTS.
moves(['F', 'FF', 'RT', 'LT', 'UT']).

% USAGE: Get exactly one random action R of all filtered valid actions for the 
% plane represented by index Idx.
randomMove(Idx, R) :- filter(Idx, F), random_member(R, F).
 
% Returns list F of all valid turns, given the index Idx, following the 
% criteria 'filterCondition'. Note: 1, 2  Need to hard coded here, due to the
% usage of swipl's "include\3" API method.
filter(1, F) :- moves(M), include(filterCondition1, M, F).
filter(2, F) :- moves(M), include(filterCondition1, M, F).

% Use 'plane remains within bounds' as filter condition. (Stays in list ic condition is met).
filterCondition1(Option) :- newPos(NewX, NewY, 1, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.
filterCondition1(Option) :- newPos(NewX, NewY, 2, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.

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

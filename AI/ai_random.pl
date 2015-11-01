:- module(ai_random, [aiRandom/1]).

:- use_module('ai_general').
:- use_module('../Game/plane').
:- use_module('../Game/plane_actions').

% Implementation of an A.I. doing random moves (under the premise that the selected
% move does not lead the plane out of bounds).
% This AI uses a virtual plane (idx = 42) to memorize temporaty positions/orintations
% [Maxou]

% Possible movements as FACTS.
moves(['F', 'FF', 'RT', 'LT', 'UT']).

% The three cannot be computed all at once, for each move influences the
% following possibilities. Therefore the temporary position must be updated 
% between the indivual move-choices. (This is covered by the randomMove 
% predicates)
aiRandom(Idx) :- retract(actions(Idx, _)),
		initTempPos(Idx),
		%print(Idx), print(':'),
		randomMove(Move1),
		randomMove(Move2),
		randomMove(Move3),
		%nl,
		retract(plane(42,_,_,_,_)),
		assert(actions(Idx, [Move1, Move2, Move3])).
			
% Initially update the temporary position and orientation to the planes' values.
initTempPos(Idx) :- plane(Idx, X, Y, _, O), assert(plane(42, X, Y, 1, O)).

% Updates the planes temporary position given a certain action.
updateTempPos(Act) :- plane(42, OldX, OldY, _, OldO), newPos(NewX, NewY, NewO, Act), retract(plane(42, OldX, OldY, _, OldO)), assert(plane(42, NewX, NewY, 1, NewO)).

% USAGE: Returns R as a randomly chosen movement.
randomMove(R) :- filter(F), random_member(R, F), updateTempPos(R).% print(R), print('.').
 
% Returns list F of all valid movements.
% The criteria used to determine which option are valid and which are invalid is:
% 'filterCondition'.
filter(F) :- moves(M), include(filterCondition, M, F).%, print(F), print( -> ).

% Use 'plane remains within bounds' as filter condition. (Stays in list if condition is met).
filterCondition(Option) :- newPos(NewX, NewY, _, Option), NewX > -1, NewX < 16, NewY > -1, NewY < 16.

% Returns the (virtual) plane's new position given a certain actino without actualy modifying the stocked predicates.
newPos(NewX, NewY, NewO, 'F') :-   plane(42, OldX, OldY, _, OldO), actionForward(42), plane(42, NewX, NewY, _, NewO), retract(plane(42, NewX, NewY, _, NewO)), assert(plane(42, OldX, OldY, 1, OldO)).
newPos(NewX, NewY, NewO, 'FF') :-  plane(42, OldX, OldY, _, OldO), actionFastForward(42), plane(42, NewX, NewY, _, NewO), retract(plane(42, NewX, NewY, _, NewO)), assert(plane(42, OldX, OldY, 1, OldO)).
newPos(NewX, NewY, NewO, 'RT') :-  plane(42, OldX, OldY, _, OldO), actionRightTurn(42), plane(42, NewX, NewY, _, NewO), retract(plane(42, NewX, NewY, _, NewO)), assert(plane(42, OldX, OldY, 1, OldO)).
newPos(NewX, NewY, NewO, 'LT') :-  plane(42, OldX, OldY, _, OldO), actionLeftTurn(42), plane(42, NewX, NewY, _, NewO), retract(plane(42, NewX, NewY, _, NewO)), assert(plane(42, OldX, OldY, 1, OldO)).
newPos(NewX, NewY, NewO, 'UT') :-  plane(42, OldX, OldY, _, OldO), actionUTurn(42), plane(42, NewX, NewY, _, NewO), retract(plane(42, NewX, NewY, _, NewO)), assert(plane(42, OldX, OldY, 1, OldO)).

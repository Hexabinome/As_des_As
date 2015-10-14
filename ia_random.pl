% Implementation of an A.I. doing random moves (under the prmise that the selected
% move does not lead the plane out of bounds).
% [Maxou]

%iaPlayer(Idx) :- assert(actions(Idx, [Move1, Move2, Move3]))

% Possible movements as facts
moves(['F', 'FF', 'RT', 'LT', 'UT']).

%get one random action of all filtered valid actions
randomMove(R) :- filter(F), random_member(R, F).
 
% generates list F of all valid turns, given the criteria 'filterCondition'.
filter(F) :- moves(M), include(filterCondition, M, F).
filterCondition(X) :- X=='F'.
filterCondition(X) :- X=='LT'.

% Invalidity tests (invalid if plane is out of boundaries)
%invalidTest(Idx) :- plane(Idx, X, _, _, _), X < 0, !.
%invalidTest(Idx) :- plane(Idx, X, _, _, _), X > 15, !.
%invalidTest(Idx) :- plane(Idx, _, Y, _, _), Y < 0, !.
%invalidTest(Idx) :- plane(Idx, _, Y, _, _), Y > 15, !.

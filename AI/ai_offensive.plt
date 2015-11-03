:- use_module('ai_offensive').
:- use_module('../Game/plane').

:- begin_tests(testsAiOffensive).

test(aiOffensiveTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOffensive(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiOffensiveBestTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOffensiveBest(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.

test(aiOffensiveBetterPositionO) :-
	setPlanePosition(1, 1, 1, 'S'),
	setPlanePosition(2, 4, 5, 'N'),
	setPlanePosition(3, 2, 2, 'S'),
	setPlanePosition(4, 2, 1, 'S'),
	setPlanePosition(5, 1, 2, 'S'),
	setPlanePosition(6, 0, 0, 'S'),
	betterPositionO(1, 2, 3, 2),
	betterPositionO(1, 2, 4, 2),
	betterPositionO(1, 2, 5, 2),
	betterPositionO(6, 2, 1, 2),
	betterPositionO(6, 2, 3, 2),
	betterPositionO(6, 2, 4, 2),
	betterPositionO(6, 2, 5, 2),
	not(betterPositionO(3, 2, 1, 2)),
	not(betterPositionO(4, 2, 1, 2)),
	not(betterPositionO(5, 2, 1, 2)),
	not(betterPositionO(1, 2, 6, 2)),
	not(betterPositionO(3, 2, 6, 2)),
	not(betterPositionO(4, 2, 6, 2)),
	not(betterPositionO(5, 2, 6, 2))
	.
	
	
:- end_tests(testsAiOffensive).

resetActions(Idx) :-
	retract(actions(Idx, _)),
	assert(actions(Idx, 0)).
	
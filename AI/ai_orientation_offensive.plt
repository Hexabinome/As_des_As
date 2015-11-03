:- use_module('ai_orientation_offensive').
:- use_module('../Game/plane').

:- begin_tests(testsAiOrOffensive).

test(aiOrOffensiveTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOrOffensive(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiOrOffensiveBestTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOrOffensiveBest(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.

test(aiOrOffensiveBetterPosition) :-
	setPlanePosition(1, 5, 1, 'N'),
	setPlanePosition(2, 5, 1, 'S'),
	setPlanePosition(3, 4, 5, 'N'),
	betterPositionOrO(1, 3, 2, 3),
	betterPositionOrO(2, 3, 1, 3)
	.
	
:- end_tests(testsAiOrOffensive).

:- use_module('ai_orientation_defensive').
:- use_module('../Game/plane').

:- begin_tests(testsAiOrDefensive).

test(aiOrDefensiveTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOrDefensive(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiOrDefensiveBestTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiOrDefensiveBest(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.

test(aiOrDefensiveBetterPosition) :-
	setPlanePosition(1, 5, 1, 'N'),
	setPlanePosition(2, 5, 1, 'S'),
	setPlanePosition(3, 4, 5, 'N'),
	betterPositionOrD(1, 3, 2, 3),
	betterPositionOrD(2, 3, 1, 3)
	.
	
:- end_tests(testsAiOrDefensive).

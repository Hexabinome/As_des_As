:- use_module('ai_defensive').
:- use_module('../Game/plane').

:- begin_tests(testsAiDefensive).

test(aiDefensiveTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiDefensive(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiDefensiveBestTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiDefensiveBest(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.

test(aiDefensiveBetterPositionD) :-
	setPlanePosition(1, 1, 1, 'S'),
	setPlanePosition(2, 4, 5, 'N'),
	setPlanePosition(3, 2, 2, 'S'),
	setPlanePosition(4, 2, 1, 'S'),
	setPlanePosition(5, 1, 2, 'S'),
	betterPositionD(3, 2, 1, 2),
	not(betterPositionD(1, 2, 3, 2)),
	not(betterPositionD(4, 2, 3, 2)),
	betterPositionD(3, 2, 4, 2)
	.

:- end_tests(testsAiDefensive).

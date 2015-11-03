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
	false.
	
:- end_tests(testsAiOffensive).

resetActions(Idx) :-
	retract(actions(Idx, _)),
	assert(actions(Idx, 0)).
	
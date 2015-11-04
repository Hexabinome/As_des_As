:- use_module('ai_hybride').
:- use_module('../Game/plane').

:- begin_tests(testsAiHybride).

test(aiHybrideTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiHybrid(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiHybrideNonDeterministeTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiHybridNonDeterministic(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
:- end_tests(testsAiHybride).

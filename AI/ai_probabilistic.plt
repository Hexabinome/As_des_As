:- use_module('ai_probabilistic').
:- use_module('../Game/plane').

:- begin_tests(testsAiProbab).

test(aiProbabilisticTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiProbab(1, 0.5),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
test(aiMechanteTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiMechante(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
:- end_tests(testsAiProbab).

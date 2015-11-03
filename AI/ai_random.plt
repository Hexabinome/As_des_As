:- use_module('ai_random').
:- use_module('../Game/plane').

:- begin_tests(testsAiRandom).

test(aiRandom) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiRandom(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.
	
:- end_tests(testsAiRandom).

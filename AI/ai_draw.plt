:- use_module('ai_draw').
:- use_module('../Game/plane').

:- begin_tests(testsAiDraw).

test(aiDrawTest) :-
	setPlanePosition(1, 0, 0, 'S'),
	setPlanePosition(2, 15, 15, 'N'),
	resetActions(1),
	aiDraw(1),
	actions(1, A1),
	assertion(A1 \== 0)
	.

test(aiDrawBetterPositionDraw) :-
	setPlanePosition(1, 1, 1, 'S'),
	setPlanePosition(2, 4, 5, 'N'),
	setPlanePosition(3, 2, 2, 'S'),
	setPlanePosition(4, 2, 1, 'S'),
	setPlanePosition(5, 1, 2, 'S'),
	setPlanePosition(6, 0, 0, 'S'),
	betterPositionDraw(1, 2, 3, 2),
	betterPositionDraw(1, 2, 4, 2),
	betterPositionDraw(1, 2, 5, 2),
	betterPositionDraw(6, 2, 1, 2),
	betterPositionDraw(6, 2, 3, 2),
	betterPositionDraw(6, 2, 4, 2),
	betterPositionDraw(6, 2, 5, 2),
	not(betterPositionDraw(3, 2, 1, 2)),
	not(betterPositionDraw(4, 2, 1, 2)),
	not(betterPositionDraw(5, 2, 1, 2)),
	not(betterPositionDraw(1, 2, 6, 2)),
	not(betterPositionDraw(3, 2, 6, 2)),
	not(betterPositionDraw(4, 2, 6, 2)),
	not(betterPositionDraw(5, 2, 6, 2))
	.
	
	
:- end_tests(testsAiDraw).

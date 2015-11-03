:- use_module('ai_general').
:- use_module('../Game/plane').

:- begin_tests(testsAiGeneral).

test(aiGeneralCoupleActions) :-
	findall(OneAction, coupleAction(OneAction, _), Actions),
	length(Actions, NbAction),
	assertion(NbAction == 25)
	.
	
test(aiGeneralDistance) :-
	setPlanePos(1, 0, 0),
	setPlanePos(2, 15, 15),
	dist(1, 2, Dist1),
	dist(2, 1, Dist2),
	assertion(Dist1 == Dist2),
	assertion(Dist1 == 30),
	
	setPlanePos(1, 10, 5),
	setPlanePos(2, 5, 10),
	dist(1, 2, Dist3),
	dist(2, 1, Dist4),
	assertion(Dist3 == Dist4),
	assertion(Dist3 == 10)
	.
	
test(aiGeneralTestPosition) :-
	setPlanePos(1, 0, 0),
	testPosition(1),
	setPlanePos(1, 15, 15),
	testPosition(1),
	setPlanePos(1, -1, 0),
	not(testPosition(1)),
	setPlanePos(1, 0, 16),
	not(testPosition(1)),
	setPlanePos(1, 30, 30),
	not(testPosition(1)),
	setPlanePos(1, -200, 5000),
	not(testPosition(1))
	.
	
test(aiGeneralUpdate) :-
	setPlane(1, 15, 15, 30, 'N'),
	update(1, 2),
	plane(2, X1, Y1, L1, O1),
	assertion(X1 == 15), assertion(Y1 == 15), assertion(L1 == 30), assertion(O1 == 'N'),
	
	setPlane(1, 0, 5000, 5, 'S'),
	update(1, 2),
	plane(2, X2, Y2, L2, O2),
	assertion(X2 == 0), assertion(Y2 == 5000), assertion(L2 == 5), assertion(O2 == 'S').
	
:- end_tests(testsAiGeneral).

setPlanePos(Idx, X, Y) :-
	retract(plane(Idx, _, _, Life, Orientation)),
	assert(plane(Idx, X, Y, Life, Orientation)).

setPlane(Idx, X, Y, Life, Orientation) :-
	retract(plane(Idx, _, _, _, _)),
	assert(plane(Idx, X, Y, Life, Orientation))
	.

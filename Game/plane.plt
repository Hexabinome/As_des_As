:- use_module(plane).

:- begin_tests(testsPlane).

test(planeCallActionForward) :- 
	setPlanePosition(1, 5, 5, 'N'),
	callPlaneAction(1, 'F'),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 4), assertion(O1 == 'N'),
	
	setPlanePosition(1, 5, 5, 'S'),
	callPlaneAction(1, 'F'),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 6), assertion(O2 == 'S'),
	
	setPlanePosition(1, 5, 5, 'E'),
	callPlaneAction(1, 'F'),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 5), assertion(O3 == 'E'),
	
	setPlanePosition(1, 5, 5, 'W'),
	callPlaneAction(1, 'F'),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 5), assertion(O4 == 'W')
	.
	
test(planeCallActionFastForward) :- 
	setPlanePosition(1, 5, 5, 'N'),
	callPlaneAction(1, 'FF'),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 3), assertion(O1 == 'N'),
	
	setPlanePosition(1, 5, 5, 'S'),
	callPlaneAction(1, 'FF'),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 7), assertion(O2 == 'S'),
	
	setPlanePosition(1, 5, 5, 'E'),
	callPlaneAction(1, 'FF'),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 7), assertion(Y3 == 5), assertion(O3 == 'E'),
	
	setPlanePosition(1, 5, 5, 'W'),
	callPlaneAction(1, 'FF'),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 3), assertion(Y4 == 5), assertion(O4 == 'W')
	.
	
test(planeCallActionRightTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	callPlaneAction(1, 'RT'),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 6), assertion(Y1 == 4), assertion(O1 == 'E'),
	
	setPlanePosition(1, 5, 5, 'S'),
	callPlaneAction(1, 'RT'),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 4), assertion(Y2 == 6), assertion(O2 == 'W'),
	
	setPlanePosition(1, 5, 5, 'E'),
	callPlaneAction(1, 'RT'),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 6), assertion(O3 == 'S'),
	
	setPlanePosition(1, 5, 5, 'W'),
	callPlaneAction(1, 'RT'),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 4), assertion(O4 == 'N')
	.
	
test(planeCallActionLeftTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	callPlaneAction(1, 'LT'),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 4), assertion(Y1 == 4), assertion(O1 == 'W'),
	
	setPlanePosition(1, 5, 5, 'S'),
	callPlaneAction(1, 'LT'),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 6), assertion(Y2 == 6), assertion(O2 == 'E'),
	
	setPlanePosition(1, 5, 5, 'E'),
	callPlaneAction(1, 'LT'),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 4), assertion(O3 == 'N'),
	
	setPlanePosition(1, 5, 5, 'W'),
	callPlaneAction(1, 'LT'),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 6), assertion(O4 == 'S')
	.
	
test(planeCallActionUTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	callPlaneAction(1, 'UT'),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 5), assertion(O1 == 'S'),
	
	setPlanePosition(1, 5, 5, 'S'),
	callPlaneAction(1, 'UT'),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 5), assertion(O2 == 'N'),
	
	setPlanePosition(1, 5, 5, 'E'),
	callPlaneAction(1, 'UT'),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 5), assertion(Y3 == 5), assertion(O3 == 'W'),
	
	setPlanePosition(1, 5, 5, 'W'),
	callPlaneAction(1, 'UT'),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 5), assertion(Y4 == 5), assertion(O4 == 'E')
	.
	
test(planeCanFire) :- 
	setPlanePosition(1, 5, 5, 'N'),
	setPlanePosition(2, 5, 3, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'E'),
	setPlanePosition(2, 7, 5, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 7, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'W'),
	setPlanePosition(2, 3, 5, 'N'),
	canFire(1, 2),
	
	% Too far away
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 15, 'N'),
	not(canFire(1, 2)),
	
	% Behind
	setPlanePosition(1, 5, 5, 'N'),
	setPlanePosition(2, 5, 6, 'N'),
	not(canFire(1, 2)),
	
	% A côté
	setPlanePosition(1, 5, 5, 'N'),
	setPlanePosition(2, 6, 5, 'N'),
	not(canFire(1, 2)),
	
	% Distance limit
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 10, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 11, 'N'),
	not(canFire(1, 2)),
	
	% Same position
	setPlanePosition(1, 5, 5, 'N'),
	setPlanePosition(2, 5, 5, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'E'),
	setPlanePosition(2, 5, 5, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'W'),
	setPlanePosition(2, 5, 5, 'N'),
	canFire(1, 2),
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 5, 'N'),
	canFire(1, 2)
	.
	
test(planeFire) :-
	setPlanePosition(1, 5, 5, 'S'),
	setPlanePosition(2, 5, 6, 'N'),
	setPlaneLife(2, 3),
	fire(1), % Hit
	plane(2, _, _, Life1, _),
	assertion(Life1 == 2),
	
	setPlanePosition(1, 5, 5, 'N'),
	setPlanePosition(2, 10, 10, 'N'),
	fire(1), % Miss but still true
	plane(2, _, _, Life2, _),
	assertion(Life2 == 2)
	.

test(planeDecrementLife) :- 
	setPlaneLife(1, 2),
	decrementLife(1),
	plane(1, _, _, Life1, _),
	assertion(Life1 == 1),
	
	decrementLife(1),
	plane(1, _, _, Life2, _),
	assertion(Life2 == 0)
	.
	
test(planeUpdatePlanes) :-
	setPlanePosition(1, 1, 1, 'S'),
	setPlaneLife(1, 3),
	setPlanePosition(2, 3, 4, 'N'),
	setPlaneLife(2, 3),
	updatePlanes(['LT', 'RT', 'F'], ['LT', 'UT', 'F']),
	plane(1, X1, Y1, Life1, O1),
	plane(2, X2, Y2, Life2, O2),
	assertion(X1 == 3), assertion(Y1 == 4), assertion(Life1 == 2), assertion(O1 == 'S'),
	assertion(X2 == 3), assertion(Y2 == 3), assertion(Life2 == 3), assertion(O2 == 'E')
	.
	
:- end_tests(testsPlane).

setPlanePosition(Idx, X, Y, Orientation) :-
	retract(plane(Idx, _, _, Life, _)),
	assert(plane(Idx, X, Y, Life, Orientation)).
	
setPlaneLife(Idx, Life) :-
	retract(plane(Idx, X, Y, _, Orientation)),
	assert(plane(Idx, X, Y, Life, Orientation)).
	
	
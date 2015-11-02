:- use_module(plane_actions).

:- begin_tests(testsPlaneActions).

test(planeActionsCallActionForward) :- 
	setPlanePosition(1, 5, 5, 'N'),
	actionForward(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 4), assertion(O1 == 'N'),
	
	setPlanePosition(1, 5, 5, 'S'),
	actionForward(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 6), assertion(O2 == 'S'),
	
	setPlanePosition(1, 5, 5, 'E'),
	actionForward(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 5), assertion(O3 == 'E'),
	
	setPlanePosition(1, 5, 5, 'W'),
	actionForward(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 5), assertion(O4 == 'W')
	.
	
test(planeActionsCallActionFastForward) :- 
	setPlanePosition(1, 5, 5, 'N'),
	actionFastForward(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 3), assertion(O1 == 'N'),
	
	setPlanePosition(1, 5, 5, 'S'),
	actionFastForward(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 7), assertion(O2 == 'S'),
	
	setPlanePosition(1, 5, 5, 'E'),
	actionFastForward(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 7), assertion(Y3 == 5), assertion(O3 == 'E'),
	
	setPlanePosition(1, 5, 5, 'W'),
	actionFastForward(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 3), assertion(Y4 == 5), assertion(O4 == 'W')
	.
	
test(planeActionsCallActionRightTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	actionRightTurn(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 6), assertion(Y1 == 4), assertion(O1 == 'E'),
	
	setPlanePosition(1, 5, 5, 'S'),
	actionRightTurn(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 4), assertion(Y2 == 6), assertion(O2 == 'W'),
	
	setPlanePosition(1, 5, 5, 'E'),
	actionRightTurn(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 6), assertion(O3 == 'S'),
	
	setPlanePosition(1, 5, 5, 'W'),
	actionRightTurn(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 4), assertion(O4 == 'N')
	.
	
test(planeActionsCallActionLeftTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	actionLeftTurn(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 4), assertion(Y1 == 4), assertion(O1 == 'W'),
	
	setPlanePosition(1, 5, 5, 'S'),
	actionLeftTurn(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 6), assertion(Y2 == 6), assertion(O2 == 'E'),
	
	setPlanePosition(1, 5, 5, 'E'),
	actionLeftTurn(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 6), assertion(Y3 == 4), assertion(O3 == 'N'),
	
	setPlanePosition(1, 5, 5, 'W'),
	actionLeftTurn(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 4), assertion(Y4 == 6), assertion(O4 == 'S')
	.
	
test(planeActionsCallActionUTurn) :- 
	setPlanePosition(1, 5, 5, 'N'),
	actionUTurn(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 5), assertion(O1 == 'S'),
	
	setPlanePosition(1, 5, 5, 'S'),
	actionUTurn(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 5), assertion(O2 == 'N'),
	
	setPlanePosition(1, 5, 5, 'E'),
	actionUTurn(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 5), assertion(Y3 == 5), assertion(O3 == 'W'),
	
	setPlanePosition(1, 5, 5, 'W'),
	actionUTurn(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 5), assertion(Y4 == 5), assertion(O4 == 'E')
	.
	
test(planeActionsOrientateLeft) :-
	setPlanePosition(1, 5, 5, 'N'),
	turnLeft(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 5), assertion(O1 == 'W'),
	
	setPlanePosition(1, 5, 5, 'S'),
	turnLeft(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 5), assertion(O2 == 'E'),
	
	setPlanePosition(1, 5, 5, 'E'),
	turnLeft(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 5), assertion(Y3 == 5), assertion(O3 == 'N'),
	
	setPlanePosition(1, 5, 5, 'W'),
	turnLeft(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 5), assertion(Y4 == 5), assertion(O4 == 'S')
	.
	
test(planeActionsOrientateRight) :-
	setPlanePosition(1, 5, 5, 'N'),
	turnRight(1),
	plane(1, X1, Y1, _, O1),
	assertion(X1 == 5), assertion(Y1 == 5), assertion(O1 == 'E'),
	
	setPlanePosition(1, 5, 5, 'S'),
	turnRight(1),
	plane(1, X2, Y2, _, O2),
	assertion(X2 == 5), assertion(Y2 == 5), assertion(O2 == 'W'),
	
	setPlanePosition(1, 5, 5, 'E'),
	turnRight(1),
	plane(1, X3, Y3, _, O3),
	assertion(X3 == 5), assertion(Y3 == 5), assertion(O3 == 'S'),
	
	setPlanePosition(1, 5, 5, 'W'),
	turnRight(1),
	plane(1, X4, Y4, _, O4),
	assertion(X4 == 5), assertion(Y4 == 5), assertion(O4 == 'N')
	.

:- end_tests(testsPlaneActions).

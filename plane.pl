:- dynamic plane/5.
:- [plane_actions].

% Faits qui definissent les positions initiales des avions.
% Le premier argument correspond à l'indice de l'avion
plane(1, 5, 3, 3, 'S').
plane(2, 5, 13, 3, 'O').

% Execute les coups de même indice en même temps
updatePlanes([], []).
updatePlanes([Action1|ActionList1], [Action2|ActionList2]) :- 	callPlaneAction(1, Action1),
																callPlaneAction(2, Action2),
																% TODO : check if a plane can fire on the other
																updatePlanes(ActionList1, ActionList2).

% Big kind of switch, choosing between all implemented actions 
callPlaneAction(Idx, Action) :- Action == 'F', actionForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'FF', actionFastForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'RT', actionRightTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'LT', actionLeftTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'UT', actionUTurn(Idx), !.

% Error handling if unknown action. TODO : better error than "1 == 2"...
callPlaneAction(Idx, Action) :- print('Unknown action '), print(Action), print(' for index '), print(Idx), 1 == 2.

fireAvion1:-
	plane(1, X1, Y1, V1, D1), 
	plane(2, X2, Y2, V2, D2), 
	testFire(2, X1, X2, Y1, Y2, D1).
fireAvion2:-
	plane(1, X1, Y1, V1, D1), 
	plane(2, X2, Y2, V2, D2), 
	testFire(1, X2, X1, Y2, Y1, D2).

testFire(IdxEnemie, X1, X2, Y1, Y2, D1):-X1 = X2, Y1 < Y2, D1 = 'S', retirerVie(IdxEnemie).
testFire(IdxEnemie, X1, X2, Y1, Y2, D1):-X1 = X2, Y1 > Y2, D1 = 'N', retirerVie(IdxEnemie).
testFire(IdxEnemie, X1, X2, Y1, Y2, D1):-X1 < X2, Y1 = Y2, D1 = 'E', retirerVie(IdxEnemie).
testFire(IdxEnemie, X1, X2, Y1, Y2, D1):-X1 > X2, Y1 = Y2, D1 = 'O', retirerVie(IdxEnemie).
%TODO : retour true pour pouvoir continuer le programme (a changer potentiellement)
testFire(IdxEnemie, X1, X2, Y1, Y2, D1):-true.

retirerVie(Idx):-
	retract(plane(Idx, X, Y, V, D)),
	NewV is V-1,
	assert(plane(Idx, X, Y, NewV, D)).
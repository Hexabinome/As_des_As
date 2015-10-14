:- dynamic plane/5.
:- [plane_actions].

% Faits qui definissent les positions initiales des avions.
% Le premier argument correspond à l'indice de l'avion
plane(1, 0, 0, 3, 'S').
plane(2, 15, 15, 3, 'N').

% Execute les coups de même indice en même temps
updatePlanes([], []).
updatePlanes([Action1|ActionList1], [Action2|ActionList2]) :- 	callPlaneAction(1, Action1),
																callPlaneAction(2, Action2),
																fire(1), fire(2),
																(gameoverDeath ; gameoverDeath(1) ; gameoverDeath(2) ; 1 == 1),
																updatePlanes(ActionList1, ActionList2).

% Big kind of switch, choosing between all implemented actions 
callPlaneAction(Idx, Action) :- Action == 'F', actionForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'FF', actionFastForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'RT', actionRightTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'LT', actionLeftTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'UT', actionUTurn(Idx), !.

% Error handling if unknown action. TODO : better error than "1 == 2"...
callPlaneAction(Idx, Action) :- print('Unknown action '), print(Action), print(' for index '), print(Idx), 1 == 2.

% Fire methods
fire(Idx) :- 	canFire(Idx),
				plane(Idx2, _, _, _, _),
				Idx2 \== Idx,
				decrementLife(Idx2).
fire(Idx).

canFire(Idx) :- plane(Idx, X1, Y1, _, Orientation1),
				plane(Idx2, X2, Y2, _, _),
				Idx2 \== Idx,
				Orientation1 == 'N',
				X1 == X2,
				Y1 - Y2 =< 5.
canFire(Idx) :- plane(Idx, X1, Y1, _, Orientation1),
				plane(Idx2, X2, Y2, _, _),
				Idx2 \== Idx,
				Orientation1 == 'S',
				X1 == X2,
				Y2 - Y1 =< 5.
canFire(Idx) :- plane(Idx, X1, Y1, _, Orientation1),
				plane(Idx2, X2, Y2, _, _),
				Idx2 \== Idx,
				Orientation1 == 'E',
				Y1 == Y2,
				X2 - X1 =< 5.
canFire(Idx) :- plane(Idx, X1, Y1, _, Orientation1),
				plane(Idx2, X2, Y2, _, _),
				Idx2 \== Idx,
				Orientation1 == 'W',
				Y1 == Y2,
				X1 - X2 =< 5.

decrementLife(Idx) :- 	retract(plane(Idx, X, Y, Life, Orientation)),
						NewLife is Life-1,
						assert(plane(Idx, X, Y, NewLife, Orientation)).

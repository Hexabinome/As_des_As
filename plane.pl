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
																% TODO : check if a plane can fire on the other
																updatePlanes(ActionList1, ActionList2).

% Big kind of switch, choosing between all implemented actions 
callPlaneAction(Idx, Action) :- Action == 'F', actionForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'FF', actionFastForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'RT', actionRightTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'LT', actionLeftTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'UT', actionUTurn(Idx), !.
% Error handling if unknown action. TODO : better error throwing than "1 == 2"...
callPlaneAction(Idx, Action) :- print('Unknown action '), print(Action), print(' for index '), print(Idx), 1 == 2.


%updatePlanes(['FF', 'LT', 'UT'], ['LT', 'RT', 'F']).
%plane(Idx,X,Y,Life,Orientation).
%callPlaneAction(1, 'R').
%callPlaneAction(1, 'F').

:- dynamic plane/5.
:- [plane_actions].
:- [gameover].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Faits qui definissent les positions initiales des avions.
% args:	1: Indice de l'avion
%		2: Position en x
%		3: Position en y
% 		4: Points de vie
%		5: Orientation

% Les avions 1 et 2 sont les avions des joueurs
plane(1, 0, 0, 3, 'S').
plane(2, 15, 15, 3, 'W').

% Les avions 3 à 8 sont des avions temporaires pour les IA
plane(3, 0, 0, 0, 0).
plane(4, 0, 0, 0, 0).
plane(5, 0, 0, 0, 0).
plane(6, 0, 0, 0, 0).
plane(7, 0, 0, 0, 0).
plane(8, 0, 0, 0, 0).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Execute les coups de même indice en même temps
updatePlanes([], []).
updatePlanes([Action1|ActionList1], [Action2|ActionList2]) :- 	callPlaneAction(1, Action1),
																callPlaneAction(2, Action2),
																fire(1), fire(2), !,
																not(gameoverStep),
																updatePlanes(ActionList1, ActionList2).

% Big kind of switch, choosing between all implemented actions 
callPlaneAction(Idx, Action) :- Action == 'F', actionForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'FF', actionFastForward(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'RT', actionRightTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'LT', actionLeftTurn(Idx), !.
callPlaneAction(Idx, Action) :- Action == 'UT', actionUTurn(Idx), !.

% Error handling if unknown action. TODO : better error than "1 == 2"...
callPlaneAction(Idx, Action) :- write('Unknown action '), write(Action), write(' for index '), write(Idx), 1 == 2.

% Fire methods
fire(Idx) :- 	otherPlayer(Idx, OutIdx),
				canFire(Idx, OutIdx),
				decrementLife(OutIdx),
				shotDisplay(Idx, OutIdx).
fire(_).

% Prédicats qui renvoient True si l'avion d'indice IdxSrc peut
% tirer sur l'avion d'indice IdxTarget	
canFire(IdxSrc, IdxTarget) :- 	plane(IdxSrc, X1, Y1, _, Orientation1),
								plane(IdxTarget, X2, Y2, _, _),
								Orientation1 == 'N', !,
								X1 == X2,
								Distance is Y1 - Y2,
								Distance >= 0,
								Distance =< 5.
canFire(IdxSrc, IdxTarget) :- 	plane(IdxSrc, X1, Y1, _, Orientation1),
								plane(IdxTarget, X2, Y2, _, _),
								Orientation1 == 'S', !,
								X1 == X2,
								Distance is Y2 - Y1,
								Distance >= 0,
								Distance =< 5.
canFire(IdxSrc, IdxTarget) :- 	plane(IdxSrc, X1, Y1, _, Orientation1),
								plane(IdxTarget, X2, Y2, _, _),
								Orientation1 == 'E', !,
								Y1 == Y2,
								Distance is X2 - X1,
								Distance >= 0,
								Distance =< 5.
canFire(IdxSrc, IdxTarget) :- 	plane(IdxSrc, X1, Y1, _, Orientation1),
								plane(IdxTarget, X2, Y2, _, _),
								Orientation1 == 'W', !,
								Y1 == Y2,
								Distance is X1 - X2,
								Distance >= 0,
								Distance =< 5.

decrementLife(Idx) :- 	retract(plane(Idx, X, Y, Life, Orientation)),
						NewLife is Life-1,
						assert(plane(Idx, X, Y, NewLife, Orientation)).
						
% ------------------------------------------------------------------------- update sans affichage sur la console				
updatePlanesHttp([], []).
updatePlanesHttp([Action1|ActionList1], [Action2|ActionList2]) :- 	
																callPlaneAction(1, Action1),
																callPlaneAction(2, Action2),
																fireHttp(1), fireHttp(2), !,
																updatePlanesHttp(ActionList1, ActionList2).

fireHttp(Idx) :- 	
				otherPlayer(Idx, OutIdx),
				canFire(Idx, OutIdx),
				decrementLife(OutIdx).
fireHttp(_).
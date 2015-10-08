:- dynamic plane/5.
:- [plane_actions].

% Faits qui definissent les positions initiales des avions.
% Le premier argument correspond à l'indice de l'avion
plane(1, 0, 0, 3, b).
plane(2, 15, 15, 3, h).


% On passe en paramètre l'indice I de l'avion et un coup à jouer.
% Ce prédicat 
updatePlane(Index, Coup) :- plane(Index,X,Y,A,B), 
					  retract(plane(Index,X,Y,A,B)),
					  Z is X+1,
					  W is Y+1,
					  assert(plane(Index,Z,W,A,B)).

% Execute les coups de même indice en même temps
updatePlanes([], []).
updatePlanes([Coup1|ListCoup1], [Coup2|ListCoup2]) :- 	updatePlane(1, Coup1),
														updatePlane(2, Coup2),
														updatePlanes(ListCoup1, ListCoup2).

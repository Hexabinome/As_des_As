:- dynamic plane/5.


% Faits qui definissent les positions initiales des avions.
% Le premier argument correspond à l'indice de l'avion
plane(1,0, 0, 3, b).
plane(2,15, 15, 3, h).


% On passe en paramètre l'indice I de l'avion et d'autres choses.
updatePlane(I, C) :- plane(I,X,Y,A,B), 
					  retract(plane(I,X,Y,A,B)),
					  Z is X+1,
					  W is Y+1,
					  assert(plane(I,Z,W,A,B)).

updatePlanes([], []).
updatePlanes([C1|L1], [C2|L2]) :- updatePlane(1, C1), updatePlane(2, C2), updatePlanes(L1, L2).

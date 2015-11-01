% Ressources utiles pour tous types d'IA
:- use_module('../Game/plane_actions').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Genere tous les couples d'actions possibles
coupleAction(X, Y) :- action(X), action(Y).

% The Dist variable take the sum of the difference between the Idx plain absciss and OtherIdx plane absciss and same for ordinate.
dist(Idx, OtherIdx, Dist) :- plane(Idx, Ix, Iy, _, _),
			plane(OtherIdx, Jx, Jy, _, _),
			X is abs(Ix - Jx),
			Y is abs(Iy - Jy),
			Dist is X + Y.

			
% Teste si la position de l'avion d'indice Idx est sur le plateau
testPosition(Idx) :- plane(Idx, X, Y, _, _),
				X > -1, X < 16,
				Y > -1, Y < 16.

				
% Create a new plane Idx2 with the values of the Idx1
update(Idx1, Idx2) :- 	retract(plane(Idx2, _, _, _, _)),
						plane(Idx1, X, Y, Life, Orientation),
						assert(plane(Idx2, X, Y, Life, Orientation)).
						
:- module(ai_general, [coupleAction/2, dist/3, testPosition/1, update/2, testOrientation/1]).

% Ressources utiles pour tous types d'IA
:- use_module('../Game/plane_actions').
:- use_module('../Game/plane').

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


% Ce predicat permet de verifier qu'à un moment donné un avion est orienté vers
% l'endroit ou il y a le plus d'espace
% au milieu du plateau l'orientation ne compte pas.
testOrientation(Idx) :-	plane(Idx,X,_,_,Orientation),
	X < 5,
	Orientation == 'E', !.

testOrientation(Idx) :- plane(Idx,X,_,_,Orientation),
	X > 11,
	Orientation == 'W', !.

testOrientation(Idx) :- plane(Idx,X,Y,_,Orientation),
	X > 4, X < 12,
	Y < 6,
	Orientation == 'S', !.

testOrientation(Idx) :- plane(Idx,X,Y,_,Orientation),
	X > 4, X < 12,
	Y > 11,
	Orientation == 'N', !.

testOrientation(Idx) :- plane(Idx,X,Y,_,_),
	X > 4, X < 12,
	Y > 5, Y < 12, !.

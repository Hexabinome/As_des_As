:- module(ai_orientation_offensive, [aiOrOffensive/1,
									aiOrOffensiveBest/1]).

:- use_module('ai_general').
:- use_module('../Game/plane').
:- use_module('../Game/plane_actions').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Genere la prochaine liste de coups a jouer pour l'avion d'indice Idx
% Utilise un meilleur coup local aléatoire generé
aiOrOffensive(Idx):-
				% Crée une liste à partir de toutes les solutions renvoyées par playOffensive (sans doublon)
				setof(OneSol, playOrOffensive(Idx, OneSol), AllSolutions),
				% Choisi une solution parmis les solutions selectionnées
				random_member(FinalSol, AllSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).

% Genere la prochaine liste de coups a jouer pour l'avion d'indice Idx
% Utilise le meilleur coup generé
aiOrOffensiveBest(Idx):-
				% Crée une liste à partir de toutes les solutions renvoyées par playOffensive (sans doublon)
				setof(OneSol, playOrOffensive(Idx, OneSol), AllSolutions),
				% Choisi la meilleure solution trouvée
				last(AllSolutions, Sol),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, Sol)).

% Genere des listes de 3 coups qui suivent une heuristique offensive
% La logique de cette IA est de se rapprocher le plus possible de sa cible tout en prenant les coups
% qui lui permettent de tirer sur celle ci, elle ne prend pas en compte les degats qui lui sont fait
playOrOffensive(Idx, Sol) :-otherPlayer(Idx, OtherIdx),
				% Distance initiale entre les deux avions
				dist(Idx, OtherIdx, Dinit),
				retractall(bestDistO(_)),
				assert(bestDistOrO(Dinit)),
				
				% Nombre de tirs initial du meilleur
				retractall(bestFireOrO(_)),
				assert(bestFireOrO(0)),
				
				% Genere tous les couples d'actions possibles pour le premier coup
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 1 et 2
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionOrO(Idx, OtherIdx, 3, 4),
				testOrientation(3),
				
				% Genere tous les couples d'actions possibles pour le second coup
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 3 et 4
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionOrO(3, 4, 5, 6),
				testOrientation(5),
				
				
				% Genere tous les couples d'actions possibles pour le troisieme coup
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 5 et 6
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionOrO(5, 6, 7, 8),
				testOrientation(7),
				
				% Verifie que la position finale des deux avions n'est pas hors de l'air de jeu [0,15]
				testPosition(7), testPosition(8),
				
				% On verifie combien de fois l'avion d'indice Idx a pu tirer sur l'autre avion
				retractall(actFireOrO(_)),
				assert(actFireOrO(0)),
				testFireOrO(3,4),
				testFireOrO(5,6),
				testFireOrO(7,8),
				actFireOrO(F),
				% On verifie que notre liste d'actions a pu tirer au moins autant de foi que la meilleure trouvée jusqu'ici
				bestFireOrO(BF),
				BF =< F,
				retract(bestFireOrO(BF)),
				assert(bestFireOrO(F)),
				
				% On verifie que la distance finale entre les deux avions est au plus aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistOrO(BD),
				D =< BD,
				retract(bestDistOrO(BD)),
				assert(bestDistOrO(D)),
				
				%write("---------------------------"),nl,
				%write(A1),nl,write(A2),nl,write(A3),nl,write(D), nl,
				%write(B1),nl,write(B2),nl,write(B3),nl,
				%write("---------------------------"),nl,
				
				% On met nos actions dans une liste afin de les retourner
				append([A1, A2, A3], [], Sol).
				
				
				


% Is better if on the new position you can shoot on the other player.
testFireOrO(I1, I2) :- canFire(I1, I2),
					retract(actFireOrO(X)),
					assert(actFireOrO(X+1)).

testFireOrO(I1, I2) :- not(canFire(I1, I2)).
								

% Is also better if the new position is closer than the old one.
betterPositionOrO(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 >= D2.

% Ce predicat permet de verifier qu'à un moment donné un avion est orienté vers
% l'endroit ou il y a le plus d'espace
% au milieu du plateau l'orientation ne compte pas.
testOrientation(Idx) :-	plane(Idx,X,_,_,Orientation),
	X < 5,
	Orientation == 'E'.

testOrientation(Idx) :- plane(Idx,X,_,_,Orientation),
	X > 11,
	Orientation == 'W'.

testOrientation(Idx) :- plane(Idx,X,Y,_,Orientation),
	X > 4, X < 12,
	Y < 6,
	Orientation == 'S'.

testOrientation(Idx) :- plane(Idx,X,Y,_,Orientation),
	X > 4, X < 12,
	Y > 11,
	Orientation == 'N'.

testOrientation(Idx) :- plane(Idx,X,Y,_,_),
	X > 4, X < 12,
	Y > 5, Y < 12.

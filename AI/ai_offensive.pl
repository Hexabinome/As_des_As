:- module(ai_offensive, [aiOffensive/1,
									aiOffensiveBest/1,
									betterPositionO/4]).

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
aiOffensive(Idx):-
				
				% Crée une liste à partir de toutes les solutions renvoyées par playOffensive (sans doublon)
				setof(OneSol, playOffensive(Idx, OneSol), AllSolutions),
				% Choisi une solution parmis les solutions selectionnées
				random_member(FinalSol, AllSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).

% Genere la prochaine liste de coups a jouer pour l'avion d'indice Idx
% Utilise le meilleur coup generé
aiOffensiveBest(Idx):-
				
				% Crée une liste à partir de toutes les solutions renvoyées par playOffensive (sans doublon)
				setof(OneSol, playOffensive(Idx, OneSol), AllSolutions),
				% Choisi la meilleure solution trouvée
				last(AllSolutions, Sol),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, Sol)).

% Genere des listes de 3 coups qui suivent une heuristique offensive
% La logique de cette IA est de se rapprocher le plus possible de sa cible tout en prenant les coups
% qui lui permettent de tirer sur celle ci, elle ne prend pas en compte les degats qui lui sont fait
playOffensive(Idx, Sol) :-otherPlayer(Idx, OtherIdx),
				% Distance initiale entre les deux avions
				dist(Idx, OtherIdx, Dinit),
				retractall(bestDistO(_)),
				assert(bestDistO(Dinit)),
				
				% Nombre de tirs initial du meilleur
				retractall(bestFireO(_)),
				assert(bestFireO(0)),
				
				% Genere tous les couples d'actions possibles pour le premier coup
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 1 et 2
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionO(Idx, OtherIdx, 3, 4),
				
				% Genere tous les couples d'actions possibles pour le second coup
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 3 et 4
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionO(3, 4, 5, 6),
				
				
				% Genere tous les couples d'actions possibles pour le troisieme coup
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				% On effectue les actions choisies sur deux avions 'temporaires' qui ont initialement les même coordonnées que les avions 5 et 6
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionO(5, 6, 7, 8),
				
				% Verifie que la position finale des deux avions n'est pas hors de l'air de jeu [0,15]
				testPosition(7), testPosition(8),
				
				% On verifie combien de fois l'avion d'indice Idx a pu tirer sur l'autre avion
				retractall(actFireO(_)),
				assert(actFireO(0)),
				testFireO(3,4),
				testFireO(5,6),
				testFireO(7,8),
				actFireO(F),
				% On verifie que notre liste d'actions a pu tirer au moins autant de foi que la meilleure trouvée jusqu'ici
				bestFireO(BF),
				BF =< F,
				retract(bestFireO(BF)),
				assert(bestFireO(F)),
				
				% On verifie que la distance finale entre les deux avions est au plus aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistO(BD),
				D =< BD,
				retract(bestDistO(BD)),
				assert(bestDistO(D)),
				
				%write("---------------------------"),nl,
				%write(A1),nl,write(A2),nl,write(A3),nl,write(D), nl,
				%write(B1),nl,write(B2),nl,write(B3),nl,
				%write("---------------------------"),nl,
				
				% On met nos actions dans une liste afin de les retourner
				append([A1, A2, A3], [], Sol).
				
				
				


% Is better if on the new position you can shoot on the other player.
testFireO(I1, I2) :- canFire(I1, I2),
					retract(actFireO(X)),
					assert(actFireO(X+1)).

testFireO(I1, I2) :- not(canFire(I1, I2)).
								

% Is also better if the new position is closer than the old one.
betterPositionO(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 >= D2.

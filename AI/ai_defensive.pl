:- module(ai_defensive, [aiDefensive/1,
									aiDefensiveBest/1]).

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
aiDefensive(Idx):-
				% Crée une liste à partir de toutes les solutions renvoyées par playDefensive (sans doublon)
				setof(OneSol, playDefensive(Idx, OneSol), AllSolutions),
				% Choisi une solution parmis les solutions selectionnées
				random_member(FinalSol, AllSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).
				
% Genere la prochaine liste de coups a jouer pour l'avion d'indice Idx
% Utilise le meilleur coup generé
aiDefensiveBest(Idx):-
				
				% Crée une liste à partir de toutes les solutions renvoyées par playOffensive (sans doublon)
				setof(OneSol, playDefensive(Idx, OneSol), AllSolutions),
				% Choisi la meilleure solution trouvée
				last(AllSolutions, Sol),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, Sol)).
				

% Genere des listes de 3 coups qui suivent une heuristique defensive (algo min-max like)
% La logique de cette IA est de s eloigner le plus de son adversaire tout en prenant le moins de coups possible
% elle ne prend pas en compte les degats potentiels qu elle peut infliger				
playDefensive(Idx, Sol) :- otherPlayer(Idx, OtherIdx),
				% Distance initiale entre les deux avions
				dist(Idx, OtherIdx, Dinit),
				retractall(bestDistD(_)),
				assert(bestDistD(Dinit)),
				
				% Nombre de tirs initial du meilleur
				retractall(bestFireD(_)),
				assert(bestFireD(3)),
				
				% Genere tous les couples d'actions possibles pour le premier coup
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 1 et 2
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionD(Idx, OtherIdx, 3, 4),
				
				% Genere tous les couples d'actions possibles pour le second coup
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 3 et 4
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionD(3, 4, 5, 6),
				
				
				% Genere tous les couples d'actions possibles pour le troisieme coup
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 5 et 6
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionD(5, 6, 7, 8),
				
				% Verifie que la position finale des deux avions n'est pas hors de l'air de jeu [0,15]
				testPosition(7), testPosition(8),
				
				% On verifie combien de fois l'avion d'indice Idx s est fait tirer dessus
				retractall(actFireD(_)),
				assert(actFireD(0)),
				testFireD(3,4),
				testFireD(5,6),
				testFireD(7,8),
				actFireD(F),
				bestFireD(BF),
				F =< BF,
				retract(bestFireD(BF)),
				assert(bestFireD(F)),
				
				% On verifie que la distance finale entre les deux avions est au moins aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistD(BD),
				D >= BD,
				retract(bestDistD(BD)),
				assert(bestDistD(D)),
				
				% On met nos actions dans une liste afin de les retourner
				append([A1, A2, A3], [], Sol).
				
				
% Is better if on the new position you can shoot on the other player.
testFireD(I1, I2) :- canFire(I2, I1),
					retract(actFireD(X)),
					assert(actFireD(X+1)).

testFireD(I1, I2) :- not(canFire(I2, I1)).
								

% Is also better if the new position is closer than the old one.
betterPositionD(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 =< D2.
				


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Genere la prochaine liste de coup a jouer pour l'avion d'indice Idx
aiDefensive(Idx):-
				% Crée une liste à partir de toutes les solutions renvoyées par playDefensive (sans doublon)
				setof(OneSol, playDefensive(Idx, OneSol), AllSolutions),
				
				%write(Idx), nl, write(AllSolutions), nl,
				% Choisi une solution parmis les solutions selectionnées
				random_member(FinalSol, AllSolutions),
				
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).
				

% Genere des listes de 3 coups qui suivent une heuristique defensive (algo min-max like)
% La logique de cette IA est de s eloigner le plus de son adversaire tout en prenant le moins de coups possible
% elle ne prend pas en compte les degats potentiels qu elle peut infliger				
playDefensive(Idx, Sol) :- otherPlayer(Idx, OtherIdx),
				% Distance initiale entre les deux avions
				dist(Idx, OtherIdx, Dinit),
				retractall(bestDistD(_)),
				assert(bestDistD(Dinit)),
				
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
				
				% TODO verifier qu on ne se fait pas tirer dessus
				%retract(actFire(_)),
				%assert(actFire(0)),
				%testFireO(3,4),
				%testFireO(5,6),
				%testFireO(7,8),
				%actFire(F),
				%bestFire(BF),
				%F =< BF,
				%retract(bestFire(BF)),
				%assert(bestFire(F)),
				
				% On verifie que la distance finale entre les deux avions est au moins aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistD(BD),
				D >= BD,
				retract(bestDistD(BD)),
				assert(bestDistD(D)),
				
				% On met nos actions dans une liste afin de les retourner
				append([A1, A2, A3], [], Sol).
				
				
% Is better if on the new position you can shoot on the other player.
%testFireO(I1, I2) :- canFire(I1, I2),
%					retract(actFire(X)),
%					assert(actFire(X+1)).

%testFireO(I1, I2) :- not(canFire(I1, I2)).
								

% Is also better if the new position is closer than the old one.
betterPositionD(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 =< D2.
				


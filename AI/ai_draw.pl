:- module(ai_draw, [aiDraw/1, aiDrawBest/1, betterPositionDraw/4]).

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
aiDraw(Idx):-
				% Crée une liste à partir de toutes les solutions renvoyées par playDraw (sans doublon)
				setof(OneSol, playDraw(Idx, OneSol), AllSolutions),
				
				% Choisi une solution parmis les solutions selectionnées
                		setof(Sol, listOfFirstElem(AllSolutions, Sol), GoodSolutions),
				random_member(FinalSol, GoodSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).


aiDrawBest(Idx) :- 
				% Crée une liste à partir de toutes les solutions renvoyées par playDraw (sans doublon)
				setof(OneSol, playDraw(Idx, OneSol), AllSolutions),
				% Choisi la meilleure solution trouvée
				last(AllSolutions, Sol),
				last(Sol, Rank),
				setof(ASol,selectSol(AllSolutions, Rank, ASol), GoodSolutions),
				random_member(FinalSol, GoodSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).

% Genere des listes de 3 coups qui suivent une heuristique d'égalité (algo min-max like)
% La logique de cette IA est de rentrer en collision avec l'ennemi tout en prenant les coups
% qui lui permettent de tirer et d'être tirer dessus simultanément (recherche d'égalité de points de vie)
playDraw(Idx, Sol) :- otherPlayer(Idx, OtherIdx),
				retractall(actualRank(_)),
				assert(actualRank(0)),
				retractall(bestRank(_)),
				assert(bestRank(0)),
				% Distance initiale entre les deux avions
				dist(Idx, OtherIdx, Dinit),
				retractall(bestDistDraw(_)),
				assert(bestDistDraw(Dinit)),
				
				% Nombre de tirs initial du meilleur
				retractall(bestFireDraw(_)),
				assert(bestFireDraw(0)),
				
				% Genere tous les couples d'actions possibles pour le premier coup
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 1 et 2
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionDraw(Idx, OtherIdx, 3, 4),
				
				% Genere tous les couples d'actions possibles pour le second coup
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 3 et 4
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionDraw(3, 4, 5, 6),
				
				
				% Genere tous les couples d'actions possibles pour le troisieme coup
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				% On effectue les actions choisies sur deux avions 'tmp' ont initialement les même coordonnées que les avions 5 et 6
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				% Verifie que la position actuelle des deux avions est au moins aussi bonne que la position précedente
				betterPositionDraw(5, 6, 7, 8),
				
				% Verifie que la position finale des deux avions n'est pas hors de l'air de jeu [0,15]
				testPosition(7), testPosition(8),
				
				% On verifie combien de fois les 2 avions ont pu se tirer dessus simultanément
				retractall(actFire(_)),
				assert(actFire(0)),
				testFireDraw(3,4),
				testFireDraw(5,6),
				testFireDraw(7,8),
				
				%write("---------------------------"),nl,
				%write(A1),nl,write(A2),nl,write(A3),nl,write(D), nl,
				%write(B1),nl,write(B2),nl,write(B3),nl,
				%write("---------------------------"),nl,
				
				actionRank,
                		actualRank(Rank),
				% On met nos actions dans une liste afin de les retourner
				append([[A1, A2, A3],Rank], [], Sol).
				
				
%actionRank permet d'affecter un rang à une liste d'action, le rang 1 est meilleur que le rang 0
actionRank :-
% On verifie que notre liste d'actions a pu tirer au moins autant de foi que la meilleure trouvée jusqu'ici
				bestFireDraw(BF),
				actFire(F),
				BF < F,
				retract(bestFireDraw(BF)),
				assert(bestFireDraw(F)),

				% On verifie que la distance finale entre les deux avions est au plus aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistDraw(BD),
				D =< BD,
				retract(bestDistDraw(BD)),
				assert(bestDistDraw(D)),
				bestRank(Rank),
				NewRank is Rank+1,
				retractall(actualRank(_)),
				assert(actualRank(NewRank)),
				retractall(bestRank(_)),
				assert(bestRank(NewRank)).

actionRank :-
% On verifie que notre liste d'actions a pu tirer au moins autant de foi que la meilleure trouvée jusqu'ici
				bestFireDraw(BF),
				actFire(F),
				BF = F,
				retract(bestFireDraw(BF)),
				assert(bestFireDraw(F)),

				% On verifie que la distance finale entre les deux avions est au plus aussi grande que la meilleur trouvée jusqu'ici
				dist(7, 8, D),
				bestDistDraw(BD),
				D =< BD,
				retract(bestDistDraw(BD)),
				assert(bestDistDraw(D)),!.	


% Is better if on the new position you can shoot on the other player and he can shoot you.
testFireDraw(I1, I2) :- canFire(I1, I2),
					canFire(I2, I1),
					retract(actFire(X)),
					assert(actFire(X+1)).

testFireDraw(I1, I2) :- not(canFire(I1, I2)).
								

% Is also better if the new position is closer than the old one.
betterPositionDraw(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 >= D2.

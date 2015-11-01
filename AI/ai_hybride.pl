:- module(ai_hybride, [playHybride/2,generate/2,generateAll/2,aiHybride/1,aiHybrideBest/1]).

:- use_module('../game').
:- use_module('ai_general').
:- use_module('../Game/plane').
:- use_module('../Game/plane_actions').

:- dynamic meilleurGain/1.
:- dynamic meilleurCoup/1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meilleurGain(0).
meilleurCoup([]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Implémentation d'une intelligence articificielle hybride dans le sens où elle essaie de tirer sans se faire tirer dessus aussi.
% Son but est de maximiser ses tirs tout en minimisant les possibilités de tirs de l'adversaire.
% Elle suppose que l'adversaire joue les coups qui sont le plus en sa faveur.
% Principe : A partir d'un état du jeu, on construit l'arbre de jeu c'est à dire tous les coups (triplets d'actions) possibles 
% pour l'IA et l'autre joueur tout en ne sortant pas du tableau. On évalue ensuite les coups grâce à une heuristique pour faire remonter
% les max.
% L'arbre de recherche n'a pas une grande profondeur mais un nombre très important de noeuds dû aux coups possibles à chaque "step".
% TODO : élagage alpha beta  

% P : Profondeur dans l'arbre
%minimax(1,_,_).
%minimax(P,Idx,OtherIdx) :- NewProfondeur is P -1,
%						   minimax(NewProfondeur,Idx,OtherIdx),
%						   generate(Idx, CoupIA).
						   %generate(OtherIdx,CoupOther).


aiHybride(Idx) :-
				% Crée une liste à partir de toutes les solutions renvoyées par playHybride (sans doublon)
				setof(OneSol, playHybride(Idx, OneSol), AllSolutions),
				% Choisi une solution parmis les solutions selectionnées
				random_member(FinalSol, AllSolutions),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)),
				retract(meilleurGain(_)),
				assert(meilleurGain(0)).

aiHybrideBest(Idx) :-
				% Crée une liste à partir de toutes les solutions renvoyées par playHybride (sans doublon)
				setof(OneSol, playHybride(Idx, OneSol), AllSolutions),
				% Choisi une solution parmis les solutions selectionnées
				last(AllSolutions, Sol),
				% Crée le prochain coup à jouer
				retract(actions(Idx, _)),
				assert(actions(Idx, Sol)),
				retract(meilleurGain(_)),
				assert(meilleurGain(0)).

% Pas encore fini
playHybride(Idx,ProchainCoup) :-	otherPlayer(Idx, OtherIdx), 
					    generate(Idx, CoupIA),
					    generate(OtherIdx,CoupOther),
					    h(Idx,OtherIdx,CoupIA,CoupOther,Gain),
					    meilleurGain(AncienGain),
					    Gain >= AncienGain,
					    retract(meilleurGain(_)),
					    assert(meilleurGain(Gain)),
					    ProchainCoup = CoupIA.
					    					      
	

% Heuristique qui calcule le gain associé à un coup.
% Idx : indice de l'avion de l'ia en entrée
% OtherPlayer : indice de l'autre joueur en entrée
% CoupIA : Liste d'actions de l'IA en entrée
% CoupOther : Liste d'actions de l'autre joueur
% Les deux listes doivent avoir le meme nombre d'élements.
% Gain : gain associé en sortie.
% Le gain correspond à une valeur entre -3 et 3 : 
%  - une valeur négative correspond à un nombre de tirs encaissés > au nombre de tirs donnés
%  - 0 implique pas de tirs ou 3 tirs donnés et 3 tirs reçus.
%  - Une valeur positive correspond à un nombre de tirs donnés > nombre de tirs encaissés.
% L'objectif sera ainsi de maximiser ce gain.
% Au départ on met le gain à zero et on choisit l'avion 3 et 4 comme avions temporaires
h(Idx,OtherPlayer,CoupIA,CoupOther,Gain) :- hr(Idx,OtherPlayer,3,4,CoupIA,CoupOther,0,Gain).						   			

% Effectue l'appel récursif pour le calcul de l'heuristique
% TmpPlane1 et TmpPlane2 : avions temporaires en entrée
% ActionIA : action courante de l'IA en entrée
% ActionOther : action courante de l'autre joueur en entrée
% Acc : sert d'accumulateur pour le calcul du gain
% Note : le nombre d'appel récursifs est lié au nombre d'actions dans la liste. Pour le moment on en a que 3.
% Avec cette méthode, on pourra étendre ce prédicat si on ne connait pas le nombre de coups à l'avance.
hr(_,_,_,_,[],[],Gain,Gain).
hr(Idx,OtherPlayer,TmpPlane1,TmpPlane2,[ActionIA|CoupIA],[ActionOther|CoupOther],AccGain,Gain):- 
										update(Idx, TmpPlane1), % Remplissage du premier avion temporaire
							   			update(OtherPlayer, TmpPlane2), % Remplissage du premier avion temporaire
							   			callPlaneAction(TmpPlane1, ActionIA), %  Déplacement du premier avion
							   			callPlaneAction(TmpPlane2, ActionOther), %  Déplacement du second avion
							   			(canFire(TmpPlane1, TmpPlane2) -> NewGain is AccGain + 1; % +1 si l'ia peut tirer
							   						( canFire(TmpPlane2, TmpPlane1) -> NewGain is AccGain - 1;NewGain is AccGain )), % -1 si l'autre joueur peut tirer
							   			NewTmpPlane1 is TmpPlane1 + 2, % Passage au prochain avion temporaire
							   			NewTmpPlane2 is TmpPlane2 + 2, % Passage au prochain avion temporaire
							   			hr(TmpPlane1,TmpPlane2,NewTmpPlane1,NewTmpPlane2,CoupIA,CoupOther,NewGain,Gain). % Appel récursif			   	
 
% Met tous les triplets dans une liste (j'en aurai peut etre pas besoin)
generateAll(Idx,Liste) :- setof([Action1,Action2,Action3],generate(Idx,[Action1,Action2,Action3]),Liste).

% Genere tous les triplets d'actions possibles pour un avion à partir de sa position sans sortir du tableau à la fin des 3 actions.
% Une action est gardé si on se rapproche aussi de l'autre joueur
generate(Idx,[Action1,Action2,Action3]) :- action(Action1),action(Action2),action(Action3), % Génération des triplets d'actions
					   update(Idx,3),
					   callPlaneAction(3,Action1),
					   callPlaneAction(3,Action2),
					   callPlaneAction(3,Action3),
					   testPosition(3).

					   
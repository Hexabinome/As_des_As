:- dynamic gain/0.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gain(0).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Implémentation d'une intelligence articificielle hybride dans le sens où elle essaie d'attaquer sans se faire tirer dessus aussi.
% Son but est de maximiser ses tirs tout en minimisant les possibilités de tir de l'adversaire.
% => Algo min/max
% Principe : A partir de la position actuelle du joueur, on construit l'arbre de jeu c'est à dire tous les coups 
% (triplets d'actions) possibles tout en ne sortant pas du tableau. On évalue les coups au niveau des feuilles
% de cet arbre en utilisant notre fonction heuristique et en faisant remonter le max ou le min.

% Idx : identifiant de l'avion de l'IA en entrée
playHybride(Idx,Gain) :-	otherPlayer(Idx, OtherIdx), 
					    generate(Idx, CoupIA),
					    %generate(OtherIdx,CoupOther),
					    h(Idx,OtherIdx,CoupIA,Gain).					      
	

% Heuristique qui calcule le gain associé à un coup.
% Idx : indice de l'avion de l'ia en entrée
% OtherPlayer : indice de l'autre joueur en entrée
% CoupIA : Liste d'actions de l'IA en entrée
% CoupOther : Liste d'actions de l'autre joueur
% Gain : gain associé en sortie
% Au départ on met le gain à zero pour le moment et on choisit l'avion 3 et comme avions temporaires
h(Idx,OtherPlayer,CoupIA,CoupOther,Gain) :- hr(Idx,OtherPlayer,3,4,CoupIA,CoupOther,0,Gain).						   			

% 
% TmpPlane1 et TmpPlane2 : avions temporaires en entrée
% Action : action courante en entrée
% Acc : sert d'accumulateur pour le calcul du gain
hr(_,_,_,_,[],[],Gain,Gain).
hr(Idx,OtherPlayer,TmpPlane1,TmpPlane2,[ActionIA|CoupIA],[ActionOther|CoupOther],Acc,Gain):- update(Idx, TmpPlane1),
							   			update(OtherPlayer, TmpPlane2),
							   			callPlaneAction(TmpPlane1, ActionIA),
							   			callPlaneAction(TmpPlane2, ActionOther),
							   			(canFire(TmpPlane1, TmpPlane2) -> NewGain is Acc + 1; NewGain is Acc),
							   			NewTmpPlane1 is TmpPlane1 + 2,
							   			NewTmpPlane2 is TmpPlane2 + 2,
							   			hr(TmpPlane1,TmpPlane2,NewTmpPlane1,NewTmpPlane2,CoupIA,CoupOther,NewGain,Gain).			   	
 
% Met tous les triplets dans une liste (j'en aurai peut etre pas besoin)
generateAll(Idx,Liste) :- setof([Action1,Action2,Action3],generate(Idx,[Action1,Action2,Action3]),Liste).

% Genere tous les triplets d'actions possibles pour un avion à partir de sa position sans sortir du tableau à la fin des 3 actions.
generate(Idx,[Action1,Action2,Action3]) :- action(Action1),action(Action2),action(Action3), % Génération des triplets d'actions
					   update(Idx,3),
					   callPlaneAction(3,Action1),
					   callPlaneAction(3,Action2),
					   callPlaneAction(3,Action3),
					   testPosition(3).
%      
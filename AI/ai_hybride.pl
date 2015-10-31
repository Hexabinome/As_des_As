%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Implémentation d'une intelligence articificielle hybride dans le sens où
% elle essaie d'attaquer sans se faire tirer dessus aussi.
% Son but est de maximiser ses tirs tout en minimisant les possibilités de tir de l'adversaire
% => Algo min/max
% Idx : numéro de l'avion
% Actions : liste des 3 actions de l'IA

%aiHybride(Idx,Actions) :- otherPlayer(Idx, OtherIdx),
aiHybride(Idx,T) :- generateAll(Idx, T).					      


%playHybride(Idx,Sol) :- 
% Met tous les triplets dans une liste (j'en aurai peut etre pas besoin)
generateAll(Idx,Liste) :- setof([Action1,Action2,Action3],generate(Idx,[Action1,Action2,Action3]	),Liste).

% Genere tous les triplets d'actions possibles pour un avion à partir de sa position sans sortir du tableau à la fin des 3 actions.
generate(Idx,[Action1,Action2,Action3]) :- action(Action1),action(Action2),action(Action3), % Génération des triplets d'actions
					   update(Idx,3),
					   callPlaneAction(3,Action1),
					   callPlaneAction(3,Action2),
					   callPlaneAction(3,Action3),
					   testPosition(3).
%      
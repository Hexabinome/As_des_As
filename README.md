# As_des_As
###### Rules:
As des As (or Ace of Aces originally) is a plane fight board game published in 1980. This program is a playable version with multiple AIs, made with the logical programming langage Prolog.
Each turn the two players will choose three actions that will be executed at the same time. 
During each move, a plane shoots its enemy if he is in range, which makes the latter lose one life point.
A player wins when the other player's life has reached 0.

Beware! If a player is out of the board at the end of the three moves, he loses the game.

### IA:
We provide many IA with different behaviour such as:
- Random.
- Offensive.
- Defensive.
- Hybrid.

### Human Player:
In order to make this program, as ludic as possible, we provide the possibility to switch between an AI and a human player, to challenge each IA.

### IHM:
We have developed a light web interface to show the fight result between 2 AIs or to take part of the battle!

selectPlayers(J1, J2)
*-1->Human player
*0->aiRandom
*1->aiOffensive
*2->aiDefensive
*3->aiDraw
*4->aiOffensiveBest
*5->aiDefensiveBest
*6->aiDrawBest
*7->aiProbab with 0.5 agro
*8->aiOrOffensive
*9->aiOrDefensive
*10->aiOrOffensiveBest
*11->aiOrDefensiveBest
*12->aiHybride
*13->aiHybrideNonDeterministe
*14->aiMechante

## WARNING ! FR DOCUMENTATION
###TODO:translate :D

###Pour lancer le jeu en mode console:

-lancer game.pl
-"selectPlayer(X,Y)." avec X et Y les nombres correspondant aux types de joueur (voir description des IAs)
-pour afficher la partie et jouer pas à pas lancer "game."
-pour ne pas avoir d'affichage( seulement le vainceur à la fin) lancer "gameNoDisplay."

###Pour lancer le jeu en mode graphique:

-lancer server.pl
-"server(8000)"
-ouvrir la page avion.html contenu dans le dossier Interface
-suivre les instructions de la page html

###Pour ajouter une IA:

-creer un module dans le dossier IA
-l'IA doit être appelée selon ce format: 'monIA(Idx).' ou Idx est l'indice du joueur utilisant cette IA (1 ou 2)
-une IA doit modifier le fait 'action(Idx, ListeAction)' avec Idx l'indice du joueur et ListeAction la liste d'action generée
-importer le module de l'IA dans le fichier game.pl et ajouter les entêtes d'import dans le fichier de l'IA
-ajouter dans game.pl un predicat 'playIA(Idx, NumeroIA)' qui appelle 'monIA(Idx)'
-voila votre IA prète pour la bataille

###Pour lancer les tests:

-lancer game.pl
-"load_test_files(_)."
-"run_tests".


###DESCRIPTION DES IA

####IA random
	0 : genere des listes de 3 coups aléatoirement.


####IAs offensives:
La logique de cette IA est de se rapprocher le plus possible de sa cible tout en selectionnant les coups qui lui permettent de tirer sur celle ci, elle ne prend pas en compte les degats qui lui sont fait.
	1 :Cette IA selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	4 :Cette IA selectionne aléatoirement un meilleur coup GLOBAL (meilleur que ceux d'avant et après).
	8 :En plus de l'heuristique générale cette IA finit toujours orientée vers la partie du plateau ou il y a le plus d'espace.Cette IA selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	10 :En plus de l'heuristique générale cette IA finit toujours orientée vers la partie du plateau ou il y a le plus d'espace.Cette IA selectionne aléatoirement un meilleur coup GLOBAL (meilleur que ceux d'avant et après).


####IAs defensives:
La logique de cette IA est de s eloigner le plus de son adversaire tout en prenant le moins de coups possible
elle ne prend pas en compte les degats potentiels qu elle peut infliger
	2 :Cette IA selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	5 :Cette IA selectionne aléatoirement un meilleur coup GLOBAL (meilleur que ceux d'avant et après).
	9 :En plus de l'heuristique générale cette IA finit toujours orientée vers la partie du plateau ou il y a le plus d'espace.Cette IA selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	11 :En plus de l'heuristique générale cette IA finit toujours orientée vers la partie du plateau ou il y a le plus d'espace.Cette IA selectionne aléatoirement un meilleur coup GLOBAL (meilleur que ceux d'avant et après).


####IAs hybrides:
Ces IAs combinent des comportements offensifs et defensifs.
	3 :Cette IA cherche l'égalité, par collision ou par tirs simultanés, selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	6 :Cette IA cherche l'égalité, par collision ou par tirs simultanés, selectionne aléatoirement un meilleur coup GLOBAL (meilleur que ceux d'avant et après).
	7 :Cette IA utilise des probabilités pour generer des coups soit offensifs soit defensifs, selectionne aléatoirement un meilleur coup LOCAL (meilleur que ceux d'avant).
	12 :La logique de cette IA est de privilegier les actions lui permettant de tirer sur son adversaire sans se faire tirer dessus, elle prend la meilleure solution globale en premiere position.
	13 :La logique de cette IA est de privilegier les actions lui permettant de tirer sur son adversaire sans se faire tirer dessus, elle prend une des meilleures solutions globales de manière aléatoire.
	14 :La logique de cette IA est d'utiliser l'IA 7(probabiliste) en changeant les ratios d'offensivité/defensivité en fonction de sa situation actuelle(points de vie).


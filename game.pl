:-dynamic avion1/3, avion2/3.

avion1(1,1,10).
avion2(1,1,10).

reset():-
	retract(avion1(_,_,0));
	retract(avion2(_,_,0)).

gameover():- avion1(_,_,0), avion2(_,_,0), print('égalité').
gameover():- avion1(_,_,0), print('Joueur 2 a gagné').
gameover():- avion2(_,_,0), print('Joueur 1 a gagné').

update():-updateAvion1(), updateAvion2().

updateAvion1():-
        %récupère X (pt de vie)
	avion1(1,1,X),
	%on le retire de la base
	retract(avion1(1,1,X)),
	Y is X-1,
	assert(avion1(1,1,Y)).

updateAvion2():-
	%récupère X (pt de vie)
	avion2(1,1,X),
	%on le retire de la base
	retract(avion2(1,1,X)),
	Y is X-1,
	assert(avion2(1,1,Y)).

etape():-
	update(),
	game().

game():- gameover(), !.
game():- etape().

lancer():-reset(); game().
%['C:/Users/Djowood/Documents/INSA/Prolog/Projet/As_des_As/game'].

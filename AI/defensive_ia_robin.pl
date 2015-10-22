:- [plane_actions].
:- [plane].

%% Comportement defensif :
%% ne pas perdre de points
%% s'eloigner

%% calculer tous nos coups possibles (liste de coups)
action('F').
action('FF').
action('RT').
action('LT').
action('UT').

posibility(X,Y) :- action(X), action(Y).

createVirtualPlane(Vidx1, Vidy1):-
      plane(1,Xx,Yx,Viex,Orientationx),
      plane(2,Xy,Yy,Viey,Orientationy),
      % Best ghost plane
      assert(plane(Vidx1,Xy,Yy,Viex,Orientationy)),
      assert(plane(Vidy1,Xy,Yy,Viey,Orientationy)).

nextStep(Vidx1, Vidy2):- posibility(X1,Y1),
      callPlaneAction(Vidy2, Y1),
      callPlaneAction(Vidx2, X1).

calculateNextVirtualPlane(Vidx, Vidy):-
%% on recupere les fantome stockes
      plane(Vidx,Xx,Yx,Viex,Orientationx),
      plane(Vidy,Xy,Yy,Viey,Orientationy),
      Vidx1 is Vidx + 1,
      Vidy2 is Vidy + 1,
      assert(plane(Vidx1,Xy,Yy,Viex,Orientationy)),
      assert(plane(Vidy2,Xy,Yy,Viey,Orientationy)),

%% 3prochains coups des avions de calcul
      nextStep(Vidx1, Vidy2),
      not canFire(Vidy2),
      nextStep(Vidx1, Vidy2),
      not canFire(Vidy2),
      nextStep(Vidx1, Vidy2),
      not canFire(Vidy2),
%enregistre la meilleur solution
      saveVirtualPlane(Vidx, Vidx2),
% Suppression des avions de calcul
      retract(plane(Vidx1,_,_,_,_)),
      retract(plane(Vidy2,_,_,_,_)).

saveVirtualPlane(Vidx, Vidx2):-
            retract(plane(Vidx,_,_,_,_)),
            plane(Vidx2, X, Y, Life, Orientation),
            assert(plane(Vidx, X, Y, Life, Orientation)).

%ToDo: retract la structure action et assert la nouvelle avec les 3 coups.

%%  -----------------------------------
%% test :-
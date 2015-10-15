actions(3, []).
actions(4, []).

action('FF').
action('F').
action('RT').
action('LT').
action('UT').

coupleAction(X, Y) :- action(X), action(Y).

aiOffensive(Idx) :- otherPlayer(Idx, OtherIdx),
				dist(Idx, OtherIdx, Dinit),
				% Initial distance between planes
				assert(bestDist(Dinit)),
				
				% Generate all couples of actions for the first move
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Compare if the position is better for the couple of planes Idx/OtherIdx or 3/4
				write('TRY FIRST'), nl,
				betterPosition(Idx, OtherIdx, 3, 4),
				write('FOUND FIRST'), nl,
				
				% Generate all couples of actions for the second move
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				betterPosition(3, 4, 5, 6),
				
				
				% Generate all couples of actions for the third move
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				betterPosition(5, 6, 7, 8),
				
				dist(7, 8, D),
				bestDist(BD),
				D < BD,
				retract(bestDist(BD)),
				assert(bestDist(D)),
				%write(A1),nl,
				%write(A2),nl,
				%write(A3),nl,
				%write(B1),nl,
				%write(B2),nl,
				%write(B3),nl,
				%write(D), nl,
				retract(actions(Idx, _)),
				assert(actions(Idx, [A1, A2, A3])),
				% The first solution. TODO : choose beetween all best solutions (randomly)
				!.
				
				
% Update plane Idx2 with values of plane Idx1
update(Idx1, Idx2) :- 	retract(plane(Idx2, _, _, _, _)),
						plane(Idx1, X, Y, Life, Orientation),
						assert(plane(Idx2, X, Y, Life, Orientation)).

% Is better if on the new position you can shoot on the other player.
betterPosition(I1, I2, J1, j2) :- canFire(J1, J2).

% Is also better if the new position is closer than the old one.
betterPosition(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 > D2.
				

dist(I, J, Dist) :- plane(I, Ix, Iy, _, _),
			plane(J, Jx, Jy, _, _),
			X is abs(Ix - Jx),
			Y is abs(Iy - Jy),
			Dist is X + Y.
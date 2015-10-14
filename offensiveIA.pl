actions(3, []).
actions(4, []).

action('FF').
action('F').
action('RT').
action('LT').
action('UT').

coupleaction(X,Y) :- action(X), action(Y).

offensiveIA :- dist(1,2, Dinit),
				%initial distance between planes
				assert(bestDist(Dinit)),
				listing(plane),
				coupleaction(A1, B1), %generate all couples of actions
				update(1,3),
				update(2,4),
				callPlaneAction(3,A1),
				callPlaneAction(4,B1),
				betterPosition(1,2,3,4),
				%valid changes
				coupleaction(A2, B2),
				%rollback
				update(3,5),
				update(4,6),
				callPlaneAction(5,A2),
				callPlaneAction(6,B2),
				betterPosition(3,4,5,6),
				%valid changes
				coupleaction(A3, B3),
				%rollback
				update(5,7),
				update(6,8),
				callPlaneAction(7,A3),
				callPlaneAction(8,B3),
				betterPosition(5,6,7,8),
				dist(7,8, D),
				bestDist(BD),
				D < BD,
				write(D),nl,
				listing(plane),
				retract(bestDist(BD)),
				assert(bestDist(D)),
				write(A1),nl,
				write(A2),nl,
				write(A3),nl,
				write(B1),nl,
				write(B2),nl,
				write(B3),nl.
				
				
% update plane Idx2 with values of plane Idx1
update(Idx1, Idx2) :- retract(plane(Idx2,_,_,_,_)),
				plane(Idx1, X, Y, Pdv, Orientation),
				assert(plane(Idx2, X, Y, Pdv, Orientation)).
		
		
				
betterPosition(I1, I2, J1, J2) :- dist(I1, I2, D1),
				dist(J1, J2, D2),
				D1 > D2.
				


dist(I, J, Dist) :- plane(I, Ix, Iy, _, _),
			plane(J, Jx, Jy, _, _),
			X is abs(Ix - Jx),
			Y is abs(Iy - Jy),
			Dist is X + Y.
			
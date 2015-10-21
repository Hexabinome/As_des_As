:- dynamic actFire/1.
:- dynamic bestFire/1.
actions(3, []).
actions(4, []).

bestFire(0).
actFire(0).

coupleAction(X, Y) :- action(X), action(Y).

aiOffensive(Idx):- 
				findall(OneSol, playOffensive(Idx, OneSol), AllSolutions),
				
				write(Idx), nl, write(AllSolutions), nl,
				% Choose one solution of all of them
				random_member(FinalSol, AllSolutions),
				retract(actions(Idx, _)),
				assert(actions(Idx, FinalSol)).

randomOfDeath :- % If random > 7 alors true
					random(0, 12, X),
					X > 7.


playOffensive(Idx, Sol) :- otherPlayer(Idx, OtherIdx),
				dist(Idx, OtherIdx, Dinit),
				% Initial distance between planes
				retractall(bestDistO(_)),
				assert(bestDistO(Dinit)),
				% Generate all couples of actions for the first move
				coupleAction(A1, B1),
				update(Idx, 3),
				update(OtherIdx, 4),
				callPlaneAction(3, A1),
				callPlaneAction(4, B1),
				% Compare if the position is better for the couple of planes Idx/OtherIdx or 3/4
				betterPositionO(Idx, OtherIdx, 3, 4),
				
				% Generate all couples of actions for the second move
				coupleAction(A2, B2),
				update(3, 5),
				update(4, 6),
				callPlaneAction(5, A2),
				callPlaneAction(6, B2),
				betterPositionO(3, 4, 5, 6),
				
				
				% Generate all couples of actions for the third move
				coupleAction(A3, B3),
				update(5, 7),
				update(6, 8),
				callPlaneAction(7, A3),
				callPlaneAction(8, B3),
				betterPositionO(5, 6, 7, 8),
				testPosition(7), testPosition(8),
				retract(actFire(_)),
				assert(actFire(0)),
				testFireO(3,4),
				testFireO(5,6),
				testFireO(7,8),
				actFire(F),
				bestFire(BF),
				F =< BF,
				retract(bestFire(BF)),
				assert(bestFire(F)),
				dist(7, 8, D),
				bestDistO(BD),
				D < BD,
				retract(bestDistO(BD)),
				assert(bestDistO(D)),
				
				append([A1, A2, A3], [], Sol).
				
				
				
% Create a new plane Idx2 with the values of the Idx1
update(Idx1, Idx2) :- 	retract(plane(Idx2, _, _, _, _)),
						plane(Idx1, X, Y, Life, Orientation),
						assert(plane(Idx2, X, Y, Life, Orientation)).

% Is better if on the new position you can shoot on the other player.
testFireO(I1, I2) :- canFire(I1, I2),
					retract(actFire(X)),
					assert(actFire(X+1)).

testFireO(I1, I2) :- not(canFire(I1, I2)).
								

% Is also better if the new position is closer than the old one.
betterPositionO(I1, I2, J1, J2) :- 	dist(I1, I2, D1),
									dist(J1, J2, D2),
									D1 >= D2.
				
%The Dist variable take the sum of the difference between the Idx plain absciss and OtherIdx plane absciss and same for ordinate.
dist(Idx, OtherIdx, Dist) :- plane(Idx, Ix, Iy, _, _),
			plane(OtherIdx, Jx, Jy, _, _),
			X is abs(Ix - Jx),
			Y is abs(Iy - Jy),
			Dist is X + Y.
			
testPosition(Idx) :- plane(Idx, X, Y, _, _),
				X > -1, X < 16,
				Y > -1, Y < 16.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Contains the gameover predicates for 'simulate'. Instead of displaying the winner, it 

% --- Death tests. gameoverDeath/0 = draw testing. gameoverDeath/1 = one player testing
gameoverDeathSimulation :- gameoverDeathTest(1), gameoverDeathTest(2), simulateWinnerIs(4), !.
gameoverDeathSimulation(Idx) :- gameoverDeathTest(Idx), otherPlayer(Idx, OutIdx), simulateWinnerIs(OutIdx).

% --- Board limit tests. gameoverBoardLimit/0 = draw testing. gameoverBoardLimit/1 = one player testing
gameoverBoardLimitSimulation :- gameoverBoardLimitTest(1), gameoverBoardLimitTest(2), simulateWinnerIs(5), !.
gameoverBoardLimitSimulation(Idx) :- gameoverBoardLimitTest(Idx), otherPlayer(Idx, OutIdx), simulateWinnerIs(OutIdx).

% --- Collision at the end of the round
gameoverCollisionSimulation :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, simulateWinnerIs(3), !.

% --- Limit number of 200 rounds reached for a simulation game
gameoverRoundLimitSimulation :- round(200), simulateWinnerIs(0), !.


% End of round gameover
gameoverRoundSimulation :- gameoverRoundLimitSimulation, !.
gameoverRoundSimulation :- gameoverBoardLimitSimulation, !.
gameoverRoundSimulation :- gameoverBoardLimitSimulation(1), !.
gameoverRoundSimulation :- gameoverBoardLimitSimulation(2), !.
gameoverRoundSimulation :- gameoverCollisionSimulation, !.

% End of step gameover
gameoverStepSimulation :- gameoverDeathSimulation, !.
gameoverStepSimulation :- gameoverDeathSimulation(1).
gameoverStepSimulation :- gameoverDeathSimulation(2).

% Asserts the current winner
simulateWinnerIs(Idx) :-
	retract(gameWinner(_)),
	assert(gameWinner(Idx)).
	
updatePlanesSimulation([], []).
updatePlanesSimulation([Action1|ActionList1], [Action2|ActionList2]) :- 
		callPlaneAction(1, Action1),
		callPlaneAction(2, Action2),
		fireSimulation(1), fireSimulation(2), !,
		not(gameoverStepSimulation),
		updatePlanesSimulation(ActionList1, ActionList2).

% Fire methods for simulation
fireSimulation(Idx) :- 	otherPlayer(Idx, OutIdx),
						canFire(Idx, OutIdx),
						decrementLife(OutIdx).
				
fireSimulation(_).
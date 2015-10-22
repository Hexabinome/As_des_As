%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Death tests. gameoverDeath/0 = draw testing. gameoverDeath/1 = one player testing
gameoverDeath :- gameoverDeathTest(1), gameoverDeathTest(2), deathDisplay(1), deathDisplay(2), drawDisplay, !.
gameoverDeath(Idx) :- gameoverDeathTest(Idx), deathDisplay(Idx), otherPlayer(Idx, OutIdx), playerWinDisplay(OutIdx).
gameoverDeathTest(Idx) :- plane(Idx, _, _, Life, _), Life =< 0.

% --- Board limit tests. gameoverBoardLimit/0 = draw testing. gameoverBoardLimit/1 = one player testing
gameoverBoardLimit :- gameoverBoardLimitTest(1), gameoverBoardLimitTest(2), outOfBoundaryDisplay(1), outOfBoundaryDisplay(2), drawDisplay, !.
gameoverBoardLimit(Idx) :- gameoverBoardLimitTest(Idx), outOfBoundaryDisplay(Idx), otherPlayer(Idx, OutIdx), playerWinDisplay(OutIdx).
gameoverBoardLimitTest(Idx) :- plane(Idx, X, _, _, _), X < 0, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, X, _, _, _), X > 15, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, _, Y, _, _), Y < 0, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, _, Y, _, _), Y > 15, !.

% --- Collision at the end of the round
gameoverCollision :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, collisionDisplay, drawDisplay, !.

% --- Limit number of 2000 rounds reached
gameoverRoundLimit :- round(2000), roundLimitDisplay, drawDisplay, !.



% End of round gameover
gameoverRound :- gameoverRoundLimit, !.
gameoverRound :- gameoverBoardLimit, !.
gameoverRound :- gameoverBoardLimit(1), !.
gameoverRound :- gameoverBoardLimit(2), !.
gameoverRound :- gameoverCollision, !.

% End of step gameover
gameoverStep :- gameoverDeath, !.
gameoverStep :- gameoverDeath(1).
gameoverStep :- gameoverDeath(2).
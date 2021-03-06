﻿:- module(gameover, [gameoverStep/0,
								gameoverRound/0,
								gameoverDeath/0,
								gameoverDeath/1,
								gameoverDeathTest/1,
								gameoverBoardLimit/0,
								gameoverBoardLimit/1,
								gameoverBoardLimitTest/1,
								gameoverCollision/0,
								gameoverRoundLimit/0]).

:- use_module('plane').
:- use_module('../display').
:- use_module('../game').
								
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Death tests. gameoverDeath/0 = draw testing. gameoverDeath/1 = one player testing
gameoverDeath :- gameoverDeathTest(1), gameoverDeathTest(2), !, setEndOfGame(4), !.
gameoverDeath(Idx) :- gameoverDeathTest(Idx), !, otherPlayer(Idx, OutIdx), setEndOfGame(OutIdx).
gameoverDeathTest(Idx) :- plane(Idx, _, _, Life, _), Life =< 0.

% --- Board limit tests. gameoverBoardLimit/0 = draw testing. gameoverBoardLimit/1 = one player testing
gameoverBoardLimit :- gameoverBoardLimitTest(1), gameoverBoardLimitTest(2), setEndOfGame(5), !.
gameoverBoardLimit(Idx) :- gameoverBoardLimitTest(Idx), otherPlayer(Idx, OutIdx), setEndOfGame(OutIdx).
gameoverBoardLimitTest(Idx) :- plane(Idx, X, _, _, _), X < 0, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, X, _, _, _), X > 15, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, _, Y, _, _), Y < 0, !.
gameoverBoardLimitTest(Idx) :- plane(Idx, _, Y, _, _), Y > 15, !.

% --- Collision at the end of the round
gameoverCollision :- plane(1, X1, Y1, _, _), plane(2, X2, Y2, _, _), X1 == X2, Y1 == Y2, setEndOfGame(3), !.

% --- Limit number of 100 rounds reached
gameoverRoundLimit :- round(X), X >= 100, !, setEndOfGame(0), !.


% End of round gameover
gameoverRound :- gameoverRoundLimit, !.
gameoverRound :- gameoverBoardLimit, !.
gameoverRound :- gameoverBoardLimit(1), !.
gameoverRound :- gameoverBoardLimit(2), !.
gameoverRound :- gameoverCollision, !.

% End of step gameover
gameoverStep :- gameoverDeath, !.
gameoverStep :- gameoverDeath(1), !.
gameoverStep :- gameoverDeath(2), !.

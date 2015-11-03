:- use_module('game').
:- use_module('Game/plane').

:- begin_tests(gameTests).

test(gameIncrementRoundCounterTest) :-
	setRound(0),
	round(R1),
	assertion(R1 == 0),
	
	incrementRoundCounter,
	round(R2),
	assertion(R2 == 1),
	
	incrementRoundCounter,
	round(R3),
	assertion(R3 == 2),
	
	incrementRoundCounter,
	round(R4),
	assertion(R4 == 3),
	
	incrementRoundCounter,
	round(R5),
	assertion(R5 == 4)
	.

test(game0therPlayerTest) :-
	otherPlayer(1, P2),
	assertion(P2 == 2),
	otherPlayer(2, P1),
	assertion(P1 == 1),
	
	not(otherPlayer(0, _)),
	not(otherPlayer(-1, _)),
	not(otherPlayer(3, _)),
	not(otherPlayer(50, _))
	.

test(gameResetTest) :-
	reset,
	plane(1, X1, Y1, L1, O1),
	plane(2, X2, Y2, L2, O2),
	round(R),
	assertion(X1 == 0), assertion(Y1 == 0), assertion(L1 == 3), assertion(O1 == 'S'),
	assertion(X2 == 15), assertion(Y2 == 15), assertion(L2 == 3), assertion(O2 == 'N'),
	assertion(R == 0)
	.
	
:- end_tests(gameTests).

setRound(Counter) :-
	retractall(round(_)),
	assert(round(Counter)).

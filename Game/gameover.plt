:- use_module(gameover).
:- use_module(plane).
:- use_module('../game').

:- begin_tests(testsGameover).

% Test all gameover death predicates
test(gameoverDeath) :-
	setPlaneLifeTo(1, 0),
	setPlaneLifeTo(2, 5),
	setPlaneLifeTo(3, -15),
	gameoverDeathTest(1),
	not(gameoverDeathTest(2)),
	gameoverDeathTest(3),
	
	gameoverDeath(1), % He's dead
	not(gameoverDeath(2)), % He's not
	
	not(gameoverDeath), % Not a draw
	setPlaneLifeTo(2, 0),
	gameoverDeath, % Draw (both have 0 hp)
	setPlaneLifeTo(1, 1),
	setPlaneLifeTo(2, 1),
	not(gameoverDeath) % No draw (both have 1 hp)
	.

% Tests all gameover board limit predicates
test(gameoverBoardLimit) :-
	% Test a lot of combinations of coordinates
	setPlanePositionTo(1, 10, 10),
	not(gameoverBoardLimitTest(1)),
	setPlanePositionTo(1, -1, 10),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 10, -1),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 30, 10),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 10, 30),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, -5, -5),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, -5, 30),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 30, -5),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 30, 30),
	gameoverBoardLimitTest(1),
	setPlanePositionTo(1, 0, 0),
	not(gameoverBoardLimitTest(1)),
	setPlanePositionTo(1, 15, 15),
	not(gameoverBoardLimitTest(1)),
	
	
	% Test the same combinations of coordinates, but with the other predicate
	setPlanePositionTo(1, 10, 10),
	not(gameoverBoardLimit(1)),
	setPlanePositionTo(1, -1, 10),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 10, -1),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 30, 10),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 10, 30),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, -5, -5),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, -5, 30),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 30, -5),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 30, 30),
	gameoverBoardLimit(1),
	setPlanePositionTo(1, 0, 0),
	not(gameoverBoardLimit(1)),
	setPlanePositionTo(1, 15, 15),
	not(gameoverBoardLimit(1)),
	
	% Draw test
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, 11, 11),
	not(gameoverBoardLimit),
	setPlanePositionTo(1, -5, 10),
	setPlanePositionTo(2, 11, 11),
	not(gameoverBoardLimit),
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, 11, 40),
	not(gameoverBoardLimit),
	setPlanePositionTo(1, -5, 10),
	setPlanePositionTo(2, 11, -10),
	gameoverBoardLimit
	.
	
test(gameoverCollision) :-
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, 11, 11),
	not(gameoverCollision),
	setPlanePositionTo(1, -5, 10),
	setPlanePositionTo(2, 11, 11),
	not(gameoverCollision),
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, 11, 40),
	not(gameoverCollision),
	setPlanePositionTo(1, -5, 10),
	setPlanePositionTo(2, 11, -10),
	not(gameoverCollision),
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, 10, 10),
	gameoverCollision,
	setPlanePositionTo(1, 10, 10),
	setPlanePositionTo(2, -10, -10),
	not(gameoverCollision),
	setPlanePositionTo(1, 0, 0),
	setPlanePositionTo(2, 0, 0),
	gameoverCollision,
	setPlanePositionTo(1, 5, 10),
	setPlanePositionTo(2, 5, 10),
	gameoverCollision
	.

% Assuming the round limit is at 100
test(gameoverRoundLimit) :-
	setRoundCounter(0),
	not(gameoverRoundLimit),
	setRoundCounter(50),
	not(gameoverRoundLimit),
	setRoundCounter(100),
	gameoverRoundLimit,
	setRoundCounter(200),
	gameoverRoundLimit
	.
	
:- end_tests(testsGameover).

% Helper predicates
setPlaneLifeTo(Idx, Life) :-
	retract(plane(Idx, X, Y, _, Orientation)),
	assert(plane(Idx, X, Y, Life, Orientation)).
	
setPlanePositionTo(Idx, X, Y) :-
	retract(plane(Idx, _, _, Life, Orientation)),
	assert(plane(Idx, X, Y, Life, Orientation)).
	
setRoundCounter(Counter) :-
	retract(round(_)),
	assert(round(Counter)).

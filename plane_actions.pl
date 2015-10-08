% FORWARD
actionForward(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
						Orientation == 'N',
						!,
						retract(plane(Idx, X, Y, Life, Orientation)),
						NewY is Y-1,
						assert(plane(Idx, X, NewY, Life, Orientation)).

actionForward(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
						Orientation == 'S',
						!,
						retract(plane(Idx, X, Y, Life, Orientation)),
						NewY is Y+1,
						assert(plane(Idx, X, NewY, Life, Orientation)).
						
actionForward(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
						Orientation == 'E',
						!,
						retract(plane(Idx, X, Y, Life, Orientation)),
						NewX is X+1,
						assert(plane(Idx, NewX, Y, Life, Orientation)).

actionForward(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
						Orientation == 'W',
						!,
						retract(plane(Idx, X, Y, Life, Orientation)),
						NewX is X-1,
						assert(plane(Idx, NewX, Y, Life, Orientation)).

% FAST FORWARD						
actionFastForward(Idx) :- 	actionForward(Idx),
							actionForward(Idx).

% TURN RIGHT
actionRightTurn(Idx) :- actionForward(Idx),
						turnRight(Idx),
						actionForward(Idx).

turnRight(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'N',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'E',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
				
turnRight(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'E',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'S',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

turnRight(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'S',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'W',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

turnRight(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'W',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'N',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

% TURN LEFT				
actionLeftTurn(Idx) :- 	actionForward(Idx),
						turnLeft(Idx),
						actionForward(Idx).						

turnLeft(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'N',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'W',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

turnLeft(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'W',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'S',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
					
turnLeft(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'S',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'E',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
					
turnLeft(Idx) :- 	plane(Idx, X, Y, Life, Orientation),
					Orientation == 'E',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'N',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

% U-TURN					
actionUTurn(Idx) :- plane(Idx, X, Y, Life, Orientation),
					Orientation == 'N',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'S',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
					
actionUTurn(Idx) :- plane(Idx, X, Y, Life, Orientation),
					Orientation == 'S',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'N',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
					
actionUTurn(Idx) :- plane(Idx, X, Y, Life, Orientation),
					Orientation == 'E',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'W',
					assert(plane(Idx, X, Y, Life, NewOrientation)).
					
actionUTurn(Idx) :- plane(Idx, X, Y, Life, Orientation),
					Orientation == 'W',
					!,
					retract(plane(Idx, X, Y, Life, Orientation)),
					NewOrientation = 'E',
					assert(plane(Idx, X, Y, Life, NewOrientation)).

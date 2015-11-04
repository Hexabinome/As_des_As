:- module(simulation, [simulate/0]).

:- dynamic playerWinsCounter/2.
:- dynamic simulatedGames/1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plays a lots of game between two AIs without output and counts who wins and looses
simulatedGames(1).
maxGames(100).

playerWinsCounter(0, 0). % Round limit
playerWinsCounter(1, 0). % Player 1
playerWinsCounter(2, 0). % Player 2
playerWinsCounter(3, 0). % Collision draws
playerWinsCounter(4, 0). % Killed at the same time draw
playerWinsCounter(5, 0). % Out of board draws

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

simulate :-
		simulatedGames(NbGames),
		maxGames(MaxGames),
		% If its finished
		NbGames > MaxGames,
		displayStatistics, !.
simulate :-
	simulatedGames(NbGames),
	maxGames(MaxGames),
	% Display current round
	write('Round: '), write(NbGames), write('/'), write(MaxGames), flush,
	reset,
	playGameNoDisplay,
	!,
	incrementWinnerCounter, write(' finished in '), round(Round), write(Round), write(' rounds'), nl,
	simulate.

incrementWinnerCounter :-
								endOfGame(Idx),
								
								retract(playerWinsCounter(Idx, Wins)),
								IncrementedWins is Wins+1,
								assert(playerWinsCounter(Idx, IncrementedWins)),
								
								retract(simulatedGames(NbGames)),
								IncrementedNbGames is NbGames+1,
								assert(simulatedGames(IncrementedNbGames)).


displayStatistics :- 
						playerWinsCounter(0, RoundLimitDraws),
						playerWinsCounter(1, P1),
						playerWinsCounter(2, P2),
						playerWinsCounter(3, CollisionDraws),
						playerWinsCounter(4, DeathDraws),
						playerWinsCounter(5, BoardDraws),
						maxGames(MaxGames),
						write('Player 1 wins: '),
						write(P1),
						write('/'),
						write(MaxGames),
						nl,
						write('Player 2 wins: '),
						write(P2),
						write('/'),
						write(MaxGames),
						nl,
						write('Draws due to round limit reach: '),
						write(RoundLimitDraws),
						write('/'),
						write(MaxGames),
						nl,
						write('Draws due to a collision: '),
						write(CollisionDraws),
						write('/'),
						write(MaxGames),
						nl,
						write('Draws due to simultaneous deaths: '),
						write(DeathDraws),
						write('/'),
						write(MaxGames),
						nl,
						write('Draws due to an out of board (should not happen to an AI): '),
						write(BoardDraws),
						write('/'),
						write(MaxGames),
						nl.

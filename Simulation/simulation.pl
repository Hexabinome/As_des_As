:- module(simulation, [simulate/0]).

:- use_module('simulation_gameover_plane').

:- use_module('../Game/plane').
:- use_module('../Game/plane_actions').

:- use_module('../AI/ai_general').
:- use_module('../AI/ai_random').
:- use_module('../AI/ai_offensive').
:- use_module('../AI/ai_defensive').
:- use_module('../AI/ai_probabilistic').
:- use_module('../AI/ai_hybride').
:- use_module('../AI/ai_draw').

:- dynamic gameWinner/1.
:- dynamic playerWinsCounter/2.
:- dynamic simulatedGames/1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plays a lots of game between two AIs without output and counts who wins and looses
simulatedGames(1).
maxGames(10).


playerWinsCounter(1, 0). % Player 1
playerWinsCounter(2, 0). % Player 2
playerWinsCounter(3, 0). % Collision draws
playerWinsCounter(4, 0). % Killed at the same time draws
playerWinsCounter(5, 0). % Out of board draws

gameWinner(-1).

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
	write('Round: '), write(NbGames), write('/'), write(MaxGames), nl,
	reset,
	playOneGame,
	!,
	incrementWinnerCounter,
	simulate.

incrementWinnerCounter :-	
								gameWinner(Idx),
								retract(playerWinsCounter(Idx, Wins)),
								IncrementedWins is Wins+1,
								assert(playerWinsCounter(Idx, IncrementedWins)),
								retract(simulatedGames(NbGames)),
								IncrementedNbGames is NbGames+1,
								assert(simulatedGames(IncrementedNbGames)).

% Fills the the winning index in gameWinner fact (assert made by gameover predicates in 'simulation_gameover_plane' file
playOneGame :- gameoverRoundSimulation, !.
playOneGame :- incrementRoundCounter, (simulationStep ; gameWinner(Idx), Idx \== -1).

% Is false if one plane died during actions
simulationStep :- 
	aiRandom(1),	% joueur 1
	actions(1, ActionsP1),
	aiDefensive(2), % joueur 2
	actions(2, ActionsP2),
	updatePlanesSimulation(ActionsP1, ActionsP2), % Execution des coups de chaque avion
	playOneGame.

	
displayStatistics :- 
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
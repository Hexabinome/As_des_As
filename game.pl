:- module(game, [round/1,
							game/0,
							gameNoDisplay/0,
							playGame/0,
							otherPlayer/2,
							reset/0,
							simulate/0,
							incrementRoundCounter/0,
							selectPlayers/2,
							selectPlayer/2,
							play/1,
							endOfGame/1,
							setEndOfGame/1,
							playGameNoDisplay/0]).

:- dynamic round/1.
:- dynamic endOfGame/1.
:- dynamic player/2.
:- use_module(library(plunit)).
:- use_module('Game/plane').
:- use_module('Game/plane_actions').
:- use_module('Game/gameover').
:- use_module('Simulation/simulation').

:- use_module('Game/board').
:- use_module('Game/human_player').

:- use_module('display').

:- use_module('AI/ai_general').
:- use_module('AI/ai_random').
:- use_module('AI/ai_offensive').
:- use_module('AI/ai_defensive').
:- use_module('AI/ai_probabilistic').
:- use_module('AI/ai_hybride').
:- use_module('AI/ai_draw').
:- use_module('AI/ai_orientation_defensive').
:- use_module('AI/ai_orientation_offensive').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				FAITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Round counter
round(0).

% PLAYERS
player(1, 12).
player(2, 14).
% -1 = human
% 0 = random
% 1 = offensive
% 2 = defensive
% 3 = draw
% 4 = offensive best
% 5 = defensive best
% 6 = draw best
% 7 = probab 0.5
% 8 = orientation offensive
% 9 = orientation defensive
% 10 = orientation offensive best
% 11 = orientation defensive best
% 12 = hybride
% 13 = hybride non deterministe
% 14 = méchante

% End of game result
endOfGame(-1). % -1 = not finished
% 0 = round limit
% 1 = player 1 win
% 2 = player 2 win
% 3 = collision
% 4 = death at the same time
% 5 = out of board draw
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

game :- 
			playGame, % while not game finished
			endOfGame(Winner),
			displayEndOfGame(Winner), !.
			
gameNoDisplay :-
			playGameNoDisplay, % while not game finished
			endOfGame(Winner),
			displayEndOfGame(Winner), !.

playGame :- endOfGame(WinnerNumber), WinnerNumber \== -1, !.
playGame :- gameoverRound, !.
playGame :- incrementRoundCounter, roundDisplay, (step ; playGame).

playGameNoDisplay :- endOfGame(WinnerNumber), WinnerNumber \== -1, !.
playGameNoDisplay :- gameoverRound, !.
playGameNoDisplay :- incrementRoundCounter, (stepNoDisplay ; playGameNoDisplay).

% Game loop
step :-
	% joueur 1:
	play(1),
	actions(1, ActionsP1),
	% joueur 2:
	play(2), 
	actions(2, ActionsP2),
	displayMoves(ActionsP1, ActionsP2), % Affichage des mouvements de chacun
	updatePlanes(ActionsP1, ActionsP2), % Execution des coups de chaque avion
	playerDisplay(1),
	playerDisplay(2),
	displayBoard,
	pressToContinue,
	playGame.

stepNoDisplay :-
	% joueur 1:
	play(1),
	actions(1, ActionsP1),
	% joueur 2:
	play(2), 
	actions(2, ActionsP2),
	updatePlanesNoDisplay(ActionsP1, ActionsP2), % Execution des coups de chaque avion
	playGameNoDisplay.
	
% Increment the round counter
incrementRoundCounter :-
	retract(round(X)), 
	Y is X+1, 
	assert(round(Y)).

% If InIdx == 1, OutIdx == 2, else if InIdx == 2, OutIdx == 1
%Depending on the index of the first player, this function return the index of the other one : OutIdx
otherPlayer(InIdx, OutIdx) :- InIdx == 1, OutIdx is 2, !.
otherPlayer(InIdx, OutIdx) :- InIdx == 2, OutIdx is 1, !.
								
pressToContinue :- 	write('** Write any character + "." to go to the next step. **'), nl,
					read(_).
		
% Game reset
reset :-
	retract(plane(1, _, _, _, _)),
	retract(plane(2, _, _, _, _)),
	retractall(round(_)),
	assert(plane(1, 0, 0, 3, 'S')),
	assert(plane(2, 15, 15, 3, 'N')),
	assert(round(0)),
	setEndOfGame(-1).

setEndOfGame(Number) :-
	retractall(endOfGame(_)),
	assert(endOfGame(Number)).
	
selectPlayers(I1, I2) :-
	retractall(player(_,_)),
	assert(player(1,I1)),
	assert(player(2,I2)).

selectPlayer(Idx, Val) :-
	retract(player(Idx, _)),
	assert(player(Idx, Val)).
	
play(Idx) :-
	player(Idx, Ia),
	playIA(Idx, Ia).

% Switch between kind of player
playIA(Idx, -1) :-
	humanPlayer(Idx).
	
playIA(Idx, 0) :-
	aiRandom(Idx).
	
playIA(Idx, 1) :-
	aiOffensive(Idx).

playIA(Idx, 2) :-
	aiDefensive(Idx).
	
playIA(Idx, 3) :-
	aiDraw(Idx).
	
playIA(Idx, 4) :-
	aiOffensiveBest(Idx).
	
playIA(Idx, 5) :-
	aiDefensiveBest(Idx).

playIA(Idx, 6) :-
	aiDrawBest(Idx).

playIA(Idx, 7) :-
	aiProbab(Idx, 0.5).
	
playIA(Idx, 8) :-
	aiOrOffensive(Idx).
	
playIA(Idx, 9) :-
	aiOrDefensive(Idx).
	
playIA(Idx, 10) :-
	aiOrOffensiveBest(Idx).
	
playIA(Idx, 11) :-
	aiOrDefensiveBest(Idx).
	
playIA(Idx, 12) :-
	aiHybrid(Idx).

playIA(Idx, 13) :-
	aiHybridNonDeterministic(Idx).
	
playIA(Idx, 14) :-
	aiMechante(Idx).
	
% ----------------------------- Server exchange section 
% Game loop

stepHttp :-
	incrementRoundCounter,
	% joueur 1:
	play(1),
	actions(1, ActionsP1),
	% joueur 2:
	play(2), 
	actions(2, ActionsP2),
	
	retractall(actionHttp(_, _)),
	
	assert(actionHttp(1, ActionsP1)),
	assert(actionHttp(2, ActionsP2)),
	
	updatePlanesHttp(ActionsP1, ActionsP2).

stepHttpPlayer(ListP):-
	incrementRoundCounter,
	assert(actions(1, ListP)),
	play(2),
	actions(2, ActionsP2),
	
	retractall(actionHttp(_, _)),
	
	assert(actionHttp(1, ListP)),
	assert(actionHttp(2, ActionsP2)),

	updatePlanesHttp(ListP, ActionsP2).

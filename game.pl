:- module(game, [round/1,
							game/0,
							otherPlayer/2,
							reset/0,
							simulate/0,
							incrementRoundCounter/0,
							selectPlayers/2,
							play/1]).

:- dynamic round/1.

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

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				PREDICATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Game loop
step :-
	% joueur 1:
	play(1),
	actions(1, ActionsP1),
	% joueur 2:
	play(2), 
	actions(2, ActionsP2),
	%displayMoves(ActionsP1, ActionsP2), % Affichage des mouvements de chacun
	updatePlanes(ActionsP1, ActionsP2), % Execution des coups de chaque avion
	not(gameoverRound),
	%playerDisplay(1),
	%playerDisplay(2),
	%displayBoard,
	%pressToContinue,
	game.

%game :- gameover, !.
game :- incrementRoundCounter, roundDisplay, step.

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
	assert(round(0)).
	
selectPlayers(I1, I2) :-
	retractall(player(_,_)),
	assert(player(1,I1)),
	assert(player(2,I2)).

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
	aiHybride(Idx).

playIA(Idx, 13) :-
	aiHybrideNonDeterministe(Idx).
% ----------------------------- Server exchange section 
% Game loop

stepHttp :-
	incrementRoundCounter,
	% joueur 1:
	aiOffensiveBest(1),
	actions(1, ActionsP1),
	% joueur 2:
	aiOffensive(2), 
	actions(2, ActionsP2),
	
	retractall(actionHttp(_, _)),
	
	assert(actionHttp(1, ActionsP1)),
	assert(actionHttp(2, ActionsP2)),
	
	updatePlanesHttp(ActionsP1, ActionsP2).

stepHttpPlayer(ListP):-
	incrementRoundCounter,
	assert(actions(1, ListP)),
	aiOffensive(2),
	actions(2, ActionsP2),
	
	retractall(actionHttp(_, _)),
	
	assert(actionHttp(1, ListP)),
	assert(actionHttp(2, ActionsP2)),

	updatePlanesHttp(ListP, ActionsP2).
